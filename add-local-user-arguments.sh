#!/bin/bash

if [[ ${UID} -ne 0 ]]
then
	echo "Please run as sudo or a root user."
	exit 1
fi

# 
if [[ ${#} -lt 1 ]]
then
	echo "USAGE: ${0} USER_NAME [COMMENTS].."
	exit 1
fi

#
USER_NAME="${1}"

#
shift
COMMENTS="${@}"

#
useradd -c ${COMMENTS} -m ${USER_NAME}

#
if [[ ${?} -ne 0 ]]
then
	echo "Could not create a user."
	exit 1
fi

#
PASSWORD=$(date +%s%N | sha256sum | head -c48)

#
echo -e "${PASSWORD}\n${PASSWORD}" | passwd ${USER_NAME}

#
if [[ ${?} -ne 0 ]]
then
	echo "Password could not be set."
	exit 1
fi

#
passwd -e ${USER_NAME}

#Display
echo
echo 'username:'
echo "${USER_NAME}"
echo
echo 'password:'
echo "$PASSWORD"
echo
echo 'hostname:'
echo "${HOSTNAME}"
