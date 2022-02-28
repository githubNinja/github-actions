#!/bin/sh
set +x
set -e
MODULE_TO_BUMP=$1
VERSION_TO_BUMP=$2
GITHUB_ACCESS_TOKEN=$3
echo "Exporting path New Now:::"
#export JAVA_HOME="/c/Program Files/Amazon Corretto/jdk1.8.0_252/bin"
#export JAVA_HOME="/mnt/c/jdk1.8.0_252/bin"
#echo "Exporting path2:::" $JAVA_HOME

#export PATH=$PATH:$JAVA_HOME/bin
java -version
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
echo Input1 ${MODULE_TO_BUMP}
echo Input2 ${VERSION_TO_BUMP}
echo Input3 ${GITHUB_ACCESS_TOKEN}
git clone https://github.com/githubNinja/${MODULE_TO_BUMP}.git
echo "current dir::" `pwd`
mvn versions:set -DnewVersion=${VERSION_TO_BUMP}
echo list here2 `ls`
cd ..
echo "git checkout"
git checkout -b bump-githubNinja-patch-1
echo list here2 `ls`
git status
git add pom.xml
git commit -m "chore:bump ${MODULE_TO_BUMP}"
git push origin bump-githubNinja-patch-1
curl  -X POST -H "Content-Type: application/vnd.github.v3+json" -H "Accept:application/vnd.github.v3+json"  -H 'Authorization: token ${GITHUB_ACCESS_TOKEN}' https://api.github.com/repos/githubNinja/github-actions/pulls -d '{ "title": "'Bump::github-actions::1.0.1-SNAPSHOT'", "body": "Auto Bump Pull Request.", "head": "bump-githubNinja-patch-1", "base": "main" }'
ls
