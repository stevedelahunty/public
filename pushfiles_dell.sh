#!/bin/sh

echo "Pushing file to bldecos-5..."
echo -n "Username on bldecos-5? "
read username
(cd html; scp * $username@10.51.1.95:/var/www/html/openswitch)


