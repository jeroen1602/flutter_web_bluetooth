#!/usr/bin/env bash

if [[ "$(git update-index --refresh)" ]]; then
  echo "There are changes in git, commit them first!"
  exit 3
fi

echo "Removing unneeded folders"
rm -rfv chrome-experimental-launch || exit 4
rm -rfv scripts || exit 4
rm -rfv test || exit 4
rm -rfv example/test || exit 4
rm -rfv .idea || exit 4
rm -rfv publish.sh || exit 4
echo "Running pub publish"
flutter pub publish

echo "Reverting back to HEAD"
git reset --hard HEAD
