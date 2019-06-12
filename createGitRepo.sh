
#!/bin/bash

set +x

reponame=$1
org=${2:-ninan-trials}


mkdir -p $reponame
cd $reponame
pwd
echo "executing...: curl -i -H \"Authorization: token $GITHUB_TOKEN\" -d \"{\"name\": \"${reponame}\"}\" https://api.github.com/orgs/${org}/repos"
curl -i -H "Authorization: token $GITHUB_TOKEN" -d "{\"name\": \"${reponame}\"}" "https://api.github.com/orgs/${org}/repos"
rm -rf .git
git init
touch .gitignore
git remote add origin git@github.com:$org/$reponame.git
git add .
git status
rm -rf .git/hooks/pre-commit
git commit -m "Create $reponame repo"
git push --set-upstream origin master
cd ..

