#!/bin/bash

VERSION=$1

if [ -z "$VERSION" ]; then
	echo Version tag required
	exit 1
fi

test_repo=~/develop/longhorn-tests/manager/integration
engine_repo=~/develop/go/src/github.com/rancher/longhorn-engine
manager_repo=~/develop/go/src/github.com/rancher/longhorn-manager
ui_repo=~/develop/longhorn-ui

engine_prefix=rancher/longhorn-engine
ui_prefix=rancher/longhorn-ui
manager_prefix=rancher/longhorn-manager
test_prefix=rancher/longhorn-manager-test

verify_clear_uptodate_repo() {
	repo=$1
	pushd . > /dev/null

	echo Verifying $repo
	cd $repo
	BRANCH=`git rev-parse --abbrev-ref HEAD`
	if [ "$BRANCH" != "master" ]; then
		echo $repo is not at master branch
		exit 1
	fi

	if [ -n "$(git status --porcelain --untracked-files=no)" ]; then
		echo $repo is dirty
		exit 1
	fi

	git fetch
	LOCAL=`git rev-parse @`
	REMOTE=`git rev-parse origin/master`
	if [ "$LOCAL" != "$REMOTE" ]; then
		echo $repo is not up to date
		exit 1
	fi

	popd > /dev/null
}

tag_build_and_push() {
	repo=$1
	image=$2
	pushd . > /dev/null

	cd $repo
	echo Tagging $repo $VERSION
	GIT_TAG=$(git tag -l --contains HEAD | head -n 1)
	if [ "$GIT_TAG" != "$VERSION" ]; then
		git tag $VERSION
		if [ $? -ne 0 ]; then
			echo $repo fail to tag $VERSION
			exit 1
		fi
	fi
	echo Building $repo $VERSION
	make > /tmp/make.log 2>&1
	if [ $? -ne 0 ]; then
		echo $repo build failed
		exit 1
	fi
	generated_image=`cat bin/latest_image`
	if [ "$image" != "$generated_image" ]; then
		echo $repo build generated $generated_image, which is not expected as $image
		exit 1
	fi
	echo Pushing $image
	docker push $image
	if [ $? -ne 0 ]; then
		echo $repo image push failed
		exit 1
	fi

	popd > /dev/null
}

tag_build_update_yaml_and_push() {
	repo=$1
	prefix=$2
	engine_image=$3
	ui_image=$4
	pushd . > /dev/null

	cd $repo

	echo Updating yaml in $repo $VERSION
	image=${prefix}:$VERSION
	# we know what would be the output, so set it before build
	echo $image > bin/latest_image
	# those two options has no effect on test repo
	if [ -n "$engine_image" -a -n "$ui_image" ]; then
		./deploy/update_image.sh -e $engine_image -u $ui_image
		git add deploy/
		git commit -m "Update image to $image" \
			-m "Engine image: $engine_image" \
			-m "UI Image: $ui_image"
	else
		./deploy/update_image.sh
		git add deploy/
		git commit -m "Update image to $image"
	fi

	tag_build_and_push $repo $image

	popd > /dev/null
}

pushd .

verify_clear_uptodate_repo $engine_repo
verify_clear_uptodate_repo $manager_repo
verify_clear_uptodate_repo $ui_repo
verify_clear_uptodate_repo $test_repo

echo Repositories verified

engine_image=${engine_prefix}:$VERSION
ui_image=${ui_prefix}:$VERSION
tag_build_and_push $ui_repo $ui_image
tag_build_and_push $engine_repo $engine_image
tag_build_update_yaml_and_push $manager_repo $manager_prefix $engine_image $ui_image
tag_build_update_yaml_and_push $test_repo $test_prefix

echo Build and image update complete

