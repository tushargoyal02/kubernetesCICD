#!/bin/bash

#fetching latest update of files from github
git pull

# to get the most initialised commit from command[latest commit tag of git]
get_commit=`git log | head -5 | tail -1 | cut -d" " -f5`

echo $get_commit


# Now creating docker image by upper tag
docker build -t 192.168.10.160:5000/$get_commit .

# now pushing image to private registry

docker push 192.168.10.160:5000/$get_commit

#setting timeout
echo "Please wait your image is being pushed to Docker Registry.. !"
sleep 5
echo "Now updating your deployment image:"


echo "Wait we are about to list your deployments -->>>"
sleep 2
kubectl get deployments | cut -d" " -f1

echo "Pleae enter the deployment name ::"
read get_dep;


echo "Thanks for choosing : $get_dep"



kubectl set image deployment/$get_dep nginx=192.168.10.160:5000/$get_commit
