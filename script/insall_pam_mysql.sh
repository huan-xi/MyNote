yum install -y pam pam-devel
./configure --with-pam=/usr --with-mysql=/usr --with-pam-mods-dir=/usr/lib64/security
