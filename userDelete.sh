#!/bin/bash

# This will delete the user from the machine

if [[ ${ID} -ne 0 ]]
then
	echo "Please run as a sudo or as root." >&2
	exit 1
fi

if [[ ${#} -lt 1 ]]
then
	echo "USAGE: ${0} USERNAME" >&2
	exit 1
fi


# Store the paramenter in variable
USER="${1}"

# Delete an account
userdel -r ${USER} >&2

if [[ ${?} -ne 0 ]]
then
	echo "User ${USER} could NOT be deleted." >&2
	exit 1
fi

echo "User ${USER} was deleted successfully."
exit 0
