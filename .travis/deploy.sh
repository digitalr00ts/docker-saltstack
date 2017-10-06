#!/usr/bin/env bash
[ "${TRAVIS_PULL_REQUEST}" != 'false' ] && exit
[ "${TRAVIS_BRANCH}" != 'develop' ] && exit

GIT_COMMITTER_EMAIL='travis@digitalr00ts.com'
GIT_COMMITTER_NAME='Travis CI'
GIT_REPO_PUSH="git@$(git remote -v | head -n1 | grep -o --color=never 'github\.com.* ' | sed 's/\//\:/')"
GIT_BASE='master'

mkdir -p ~/.ssh/
openssl aes-256-cbc -K $encrypted_68d9c38e7b4c_key -iv $encrypted_68d9c38e7b4c_iv -in .travis/id_rsa.enc -out ~/.ssh/id_rsa -d
chmod -r 400 ~/.ssh/

git fetch origin ${GIT_BASE}:${GIT_BASE}
git checkout ${GIT_BASE}
git merge --ff-only "$TRAVIS_COMMIT"
git push ${GIT_REPO_PUSH}
