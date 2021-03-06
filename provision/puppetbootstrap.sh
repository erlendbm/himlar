#!/bin/bash

bootstrap_puppet()
{
  # packages
  if command -v yum >/dev/null 2>&1; then
    # RHEL, CentOS, Fedora
    rpm -ivh http://ftp.uninett.no/linux/epel/epel-release-latest-7.noarch.rpm
    rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
    yum -y update
    yum install -y puppet facter rubygems rubygem-deep_merge \
      rubygem-puppet-lint git vim inotify-tools
  else
    # Assume Debian/CumulusLinux
    apt-get -y install ca-certificates
    wget https://apt.puppetlabs.com/puppetlabs-release-wheezy.deb
    dpkg -i puppetlabs-release-wheezy.deb
    apt-get update && apt-get -y install puppet git ruby-deep-merge ruby-puppet-lint
    # FIXME adding wheel group here temporarily
    groupadd --system wheel
  fi

  gem install r10k --no-ri --no-rdoc

  yum install -y http://folk.uio.no/beddari/libnetcf-ruby-0.0.2-1.x86_64.rpm

  # file locations
  rm -rf /etc/puppet/manifests
  ln -sfT /opt/himlar/manifests /etc/puppet/manifests
  ln -sfT /opt/himlar/hieradata /etc/puppet/hieradata
  ln -sfT /opt/himlar/hiera.yaml /etc/puppet/hiera.yaml
  ln -sfT /etc/puppet/hiera.yaml /etc/hiera.yaml

  # Let puppetrun.sh pick up that we are now in bootstrap mode
  touch /opt/himlar/bootstrap && echo "Created bootstrap marker: /opt/himlar/bootstrap"
}

grep --quiet --silent himlar /var/lib/puppet/state/last_run_report.yaml || bootstrap_puppet

