#!/bin/bash

# UPDATE the following in /etc/ssh/sshd_config file
<------------------------------------------------------------>
# override default of no subsystems
#Subsystem      sftp    /usr/libexec/openssh/sftp-server ----------> Comment this
Subsystem       sftp    internal-sftp ------------> Add this line

Match user viraj
        ChrootDirectory %h
        X11Forwarding no
        AllowTcpForwarding no
        PermitTunnel no
        AllowAgentForwarding no
        ForceCommand internal-sftp

<------------------------------------------------------------>

# Restart ssh service

# Create a directory to share
mkdir -p /opt/sftp-share/viraj

chmod 755 /opt/sftp-share/viraj

mkdir /opt/sftp-share/viraj/data
chown viraj:root /opt/sftp-share/viraj/data
chmod 750 /opt/sftp-share/viraj/data

# Add user
useradd -d "/opt/sftp-share/viraj" -s "/bin/false" viraj
# give password

Done !!!


Access from WinSCP

