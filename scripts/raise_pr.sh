#!/bin/sh
set +x
set -e
MODULE_TO_BUMP=$1
VERSION_TO_BUMP=$2
GITHUB_ACCESS_TOKEN=$3
echo "Exporting path:::"
echo "Exporting path2:::" $JAVA_HOME

export JAVA_HOME="/c/Program Files/Amazon Corretto/jdk1.8.0_252/bin"
#export PATH=$PATH:$JAVA_HOME/bin
echo "version::" ${java -version}
echo Input1 ${MODULE_TO_BUMP}
echo Input2 ${VERSION_TO_BUMP}
echo Input3 ${GITHUB_ACCESS_TOKEN}
git clone https://github.com/githubNinja/${MODULE_TO_BUMP}.git
mvn versions:set -DnewVersion=${VERSION_TO_BUMP}
git checkout -b bump-githubNinja-patch-1
git add pom.xml
git commit -m "chore:bump ${MODULE_TO_BUMP}"
#git push origin bump-${{inputs.module_to_bump}}
git push origin bump-githubNinja-patch-1
curl  -X POST -H "Content-Type: application/vnd.github.v3+json" -H "Accept:application/vnd.github.v3+json"  -H 'Authorization: token ${GITHUB_ACCESS_TOKEN}' https://api.github.com/repos/githubNinja/github-actions/pulls -d '{ "title": "'Bump::github-actions::1.0.1-SNAPSHOT'", "body": "Auto Bump Pull Request.", "head": "bump-githubNinja-patch-1", "base": "main" }'
#echo Hello ${{ inputs.who-to-greet }}
ls
echo executing the bash script awesome !!
#bash ./good_morning.sh
