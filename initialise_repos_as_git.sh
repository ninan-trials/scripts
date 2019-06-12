
#!/bin/bash

set +x

for entry in "."/*
do
  if [ -d $entry ]; then
  	cd $entry
  	pwd	
  	entry=$(sed "s/.\///g" <<< $entry)
  	# echo "executing...: curl -i -H \"Authorization: token $GITHUB_TOKEN\" -d \"{\"name\": \"${entry}\"}\" https://api.github.com/orgs/ninan-trials/repos"
  	# curl -i -H "Authorization: token $GITHUB_TOKEN" -d "{\"name\": \"${entry}\"}" https://api.github.com/orgs/ninan-trials/repos
  	rm -rf .git
  	git init 
  	git remote add origin git@github.com:ninan-trials/$entry.git
  	git add .
  	git status
  	rm -rf .git/hooks/pre-commit
  	git commit -m "Create $entry repo"
  	git push --set-upstream origin master
  	cd ..
  fi
done


# git remote add origin git@github.com:ninan-trials/angularTrials.git


# curl -u $USERNAME:$PASSWORD https://api.github.com/orgs/$entry/repos | jq '.[].full_name' | tr -d '\r' | xargs -I '{}' curl -u $USERNAME:$PASSWORD -XDELETE https://api.github.com/repos/'{}'