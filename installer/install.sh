#!/bin/bash

install_dir=${install_dir:-/usr/bin}
initd_dir=${initd_dir:-/etc/rc.d/init.d}
daemon_script="aws_dynamodb_local"

url="http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest"

# Check preinitialization
rm -rf dynamodb_local_[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]*

echo "Downloading latest AWS DynamoDB Local..."
wget --no-check-certificate $url

echo "Installing AWS DynamoDB Local..."
tar xzvf dynamodb_local_[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9].tar.gz
mv dynamodb_local_[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] $install_dir/aws_dynamodb_local

if [ -e $initd_dir/$daemon_script ];
then
	echo "Skip install daemon script because it already exists."
else
	echo "Installing daemon script..."
	cp -upv $daemon_script $initd_dir/
	chmod 755 $initd_dir/$daemon_script
	chkconfig --add $initd_dir/$daemon_script
fi

cat <<EOT


Installing AWS DynamoDB Local has done.
You can start with the following commands:
	Start:
	/etc/init.d/aws_dynamodb_local start

	Stop:
	/etc/init.d/aws_dynamodb_local stop

For more information about DynamoDB you can get from the following page.
	http://aws.amazon.com/en/dynamodb/

Thanks!

EOT

