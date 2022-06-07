#!/bin/bash

GITLAB_TOKEN=glpat-5iCG4rvD1D-Xax-jRVbw

if [[ ${#} -lt 1 ]]
then
	echo "USGAE: ${0} NEW_URL_FILE"
	exit 1
fi

NEW_URL=`cat ${1}`
#echo "$NEW_URL"

GITLAB_ROOTGROUP=`echo $NEW_URL | cut -d '/' -f5-8 | awk 'BEGIN { FS="/" } {print $1}'`
GITLAB_SUBGROUP1=`echo $NEW_URL | cut -d '/' -f5-8 | awk 'BEGIN { FS="/" } {print $2}'`
GITLAB_SUBGROUP2=`echo $NEW_URL | cut -d '/' -f5-8 | awk 'BEGIN { FS="/" } {print $3}'`
GITLAB_SUBGROUP3=`echo $NEW_URL | cut -d '/' -f5-8 | awk 'BEGIN { FS="/" } {print $4}'`

# Search root group
rootGroupId=$(curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" "https://gitlab.com/api/v4/groups?search=$GITLAB_ROOTGROUP" | jq '.[0]["id"]')
if [ $rootGroupId == "null" ] 
then
	echo "Creating new root group..."
	rootGroupId=$(curl -d "name=$GITLAB_ROOTGROUP&path=$GITLAB_ROOTGROUP&visibility=private&lfs_enabled=true&description=Root group" -X POST "https://gitlab.com/api/v4/groups" -H "PRIVATE-TOKEN: $GITLAB_TOKEN" | jq '.["id"]')
fi
echo "Root group ID: $rootGroupId"

# Create sub group1
rootSubGroupId1=$(curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" "https://gitlab.com/api/v4/groups/$rootGroupId/subgroups?search=$GITLAB_SUBGROUP1" | jq '.[0]["id"]')
if [ $rootSubGroupId1 == "null" ]
then
	
	echo "Creating new sub group1..."
	rootSubGroupId1=$(curl -d "name=$GITLAB_SUBGROUP1&path=$GITLAB_SUBGROUP1&visibility=private&lfs_enabled=true&description=$GITLAB_SUBGROUP1 programme&parent_id=$rootGroupId" -X POST "https://gitlab.com/api/v4/groups" -H "PRIVATE-TOKEN: $GITLAB_TOKEN" | jq '.["id"]')
fi

echo "Sub group1 Id: $rootSubGroupId1"


# Create sub group2
rootSubGroupId2=$(curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" "https://gitlab.com/api/v4/groups/$rootSubGroupId1/subgroups?search=$GITLAB_SUBGROUP2" | jq '.[0]["id"]')
if [ $rootSubGroupId2 == "null" ]
then
	
	echo "Creating new sub group2..."
	rootSubGroupId2=$(curl -d "name=$GITLAB_SUBGROUP2&path=$GITLAB_SUBGROUP2&visibility=private&lfs_enabled=true&description=$GITLAB_SUBGROUP2 programme&parent_id=$rootSubGroupId1" -X POST "https://gitlab.com/api/v4/groups" -H "PRIVATE-TOKEN: $GITLAB_TOKEN" | jq '.["id"]')
fi

echo "Sub group2 Id: $rootSubGroupId2"


# Create sub group3
rootSubGroupId3=$(curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" "https://gitlab.com/api/v4/groups/$rootSubGroupId2/subgroups?search=$GITLAB_SUBGROUP3" | jq '.[0]["id"]')
if [ $rootSubGroupId3 == "null" ]
then
	
	echo "Creating new sub group3..."
	rootSubGroupId3=$(curl -d "name=$GITLAB_SUBGROUP3&path=$GITLAB_SUBGROUP3&visibility=private&lfs_enabled=true&description=$GITLAB_SUBGROUP3 programme&parent_id=$rootSubGroupId2" -X POST "https://gitlab.com/api/v4/groups" -H "PRIVATE-TOKEN: $GITLAB_TOKEN" | jq '.["id"]')
fi

echo "Sub group3 Id: $rootSubGroupId3"

# Project creation
#projectId=$(curl "https://gitlab.com/api/v4/groups/$rootSubGroupId/projects?search=$GITLAB_PROJECT" -H "PRIVATE-TOKEN: $GITLAB_TOKEN" | jq '.[0]["id"]' )
#if [ $projectId == "null" ]
#then
#	projectId=projectId=$(curl -d "path=$GITLAB_PROJECT&namespace_id=$rootSubGroupId" -X POST "$GITLAB_SERVER/api/v4/projects" -H "PRIVATE-TOKEN: $GITLAB_TOKEN" | jq '.["id"]')
#fi

#echo "Project Id: $projectId"
