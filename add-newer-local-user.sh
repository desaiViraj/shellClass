#!/bin/bash

# Check to see if run by sudo user or root
if [[ ${UID} -ne 0 ]]
then
	echo "Please run as a sudo user or as root." >&2
	exit 1
fi

# Check the arguments are passed properly
if [[ ${#} -lt 1 ]]
then
	echo "USAGE: ${0} USER_NAME [COMMENTS]..." >&2
	exit 1
fi

# Store the arguments
USER_NAME="${1}"

shift
COMMENTS="${@}"

useradd -c "${COMMENTS}" -m ${USER_NAME} &> /dev/null

# Check if the user got created ot not
if [[ ${?} -ne 0 ]]
then
	echo "User could not be created" >&2
	exit 1
fi

PASSWORD=$(date +%s%N | sha256sum | head -c 20)

# Provide password
echo -e "${PASSWORD}\n${PASSWORD}" | passwd ${USER_NAME} &> /dev/null

if [[ ${?} -ne 0 ]]
then
	echo "Password could not be set." >&2
	exit 1
fi

# Display
echo "username:"
echo "${USER_NAME}"
echo
echo "password:"
echo "${PASSWORD}"
echo
echo 'hostname:'
echo "${HOSTNAME}"
echo
