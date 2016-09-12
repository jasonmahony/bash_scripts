#!/bin/bash

NAME=tcad-solid

for i in {66..128}; do
        cp $NAME-65.cfg $NAME-$i.cfg
        sed "s/host_name\t\t\ttcad-solid-65/host_name\t\t\ttcad-solid-$i/" $NAME-$i.cfg > $NAME-$i.cfg.my;
        mv -f $NAME-$i.cfg.my $NAME-$i.cfg;
done
