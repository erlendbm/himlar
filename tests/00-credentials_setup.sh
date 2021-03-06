#!/bin/bash

echo '
os_url="http://10.0.3.14:35357/v2.0"
os_token="admintoken"
ostoken()
{
  openstack --os-token $os_token --os-url $os_url "$@"
}

os_auth_url="http://10.0.3.14:5000/v2.0"
os_username="demo"
os_password="himlar0pen"
os_project_name="demoproject"
osdemo()
{
  openstack --os-username $os_username --os-password $os_password --os-project-name $os_project_name --os-auth-url $os_auth_url "$@"
}
' > ~/openstack.config

echo "
export OS_USERNAME=demo
export OS_TENANT_NAME=demoproject
export OS_PASSWORD=himlar0pen
export OS_AUTH_URL=http://10.0.3.14:5000/v2.0/
export PS1='[\u@\h \W(keystone_demo)]\$ '
export OS_NO_CACHE=1
" > ~/keystonerc_demo


echo "
export OS_USERNAME=admin
export OS_TENANT_NAME=openstack
export OS_PASSWORD=admin_pass
export OS_AUTH_URL=http://10.0.3.14:5000/v2.0/
export PS1='[\u@\h \W(keystone_admin)]\$ '
export OS_NO_CACHE=1
" > ~/keystonerc_admin

