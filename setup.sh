#!/bin/bash
set -e

# update apt
apt-get update

# install python3
apt-get install -y -qq python3 python3-apt python3-pip python3-pycurl

# install aptitude
apt-get install -y libssl-dev apt-transport-https

# install python3.7
add-apt-repository -y ppa:deadsnakes/ppa
apt-get -qq update
apt-get install -y python3.7 python3.7-dev python3.7-gdbm python3.7-venv

# setup python3.7 modules
ln -sf /usr/lib/python3/dist-packages/apt_pkg.cpython-35m-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/apt_pkg.so
ln -sf /usr/lib/python3/dist-packages/apt_inst.cpython-35m-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/apt_inst.so
ln -sf /usr/lib/python3/dist-packages/pycurl.cpython-35m-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/pycurl.so
ln -sf /usr/lib/python3/dist-packages/_cffi_backend.cpython-35m-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/_cffi_backend.so
ln -sf /usr/lib/python3/dist-packages/_dbus_bindings.cpython-35m-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/_dbus_bindings.so
ln -sf /usr/lib/python3/dist-packages/_dbus_glib_bindings.cpython-35m-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/_dbus_glib_bindings.so

curl -sL https://bootstrap.pypa.io/get-pip.py -o /usr/bin/get-pip
chmod a+x /usr/bin/get-pip
rm -rf /root/.cache/pip
# make sure pip is configured correctly
cat << 'EOF' > /etc/pip.conf
[global]
ignore-requires-python = true
EOF
/usr/bin/python3 /usr/bin/get-pip pip==19.2.3
hash pip3

pip3 install setuptools==53.0.0 cryptography==3.3.1 wheel==0.29.0 cachetools==3.1.1
pip3 install jmespath netaddr botocore bot boto3 google-auth pyVim pyVmomi PyYAML==5.4.1 requests
pip3 install ansible-base==2.10.3 ansible==2.10.3

# remove and clean up apt
add-apt-repository -r ppa:deadsnakes/ppa
