#!/bin/bash -vx
PREFIX=$(hostname | sed -e 's/-.*$//')
DOMAIN=$(hostname -f | sed -e 's/^[a-z0-9-]*\.//')

hammer compute-resource list
for i in 1 2; do
  hammer compute-resource create --provider Libvirt  --url qemu+tcp://${PREFIX}-controller-0${i}.${DOMAIN}:16509/system --name ${PREFIX}-controller-0${i}
done
hammer compute-resource list
