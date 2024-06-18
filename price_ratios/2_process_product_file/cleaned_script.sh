#!/usr/bin/expect

# Arguments to be passed to the script
set PASS [lindex $argv 0]
set USER [lindex $argv 1]
set HOST [lindex $argv 2]
set REMOTEDIR [lindex $argv 3]


# Read the password from the file
set PASSWORD [exec cat $PASS]

# Set a longer timeout to accommodate large file transfers
set timeout 600

# Start the sftp session
spawn sftp $USER@$HOST

# Automate the login process
expect "password:"
send "$PASSWORD\r"

# Navigate to the desired directory
expect "sftp>"
send "cd $REMOTEDIR/2006-2020_Scanner_Data/Master_Files_2006-2020/Latest\r"
expect "sftp>"

# Change the local directory
send "lcd $env(TMPDIR)\r"
expect "sftp>"

# Download the producthierarchy.tsv file
send "mget products.tsv\r"
expect "sftp>"
send "bye\r"
