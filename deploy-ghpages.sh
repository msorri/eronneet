#!/usr/bin/env sh

set -e

npm run build

cd dist
rm js/*.map

git init
git add -A
git commit -m 'deploy'

git push -f git@github.com:msorri/eronneet.git master:gh-pages

cd -
