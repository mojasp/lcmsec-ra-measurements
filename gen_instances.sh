#!/bin/bash

#generates appropriate .toml configuration files for demo_instance from templatfrom template

players=60

for i in $(seq 1 $players); do
    cat template_instance.toml | sed -e "s/\\$/${i}/g" > "test_instances/${i}.toml"
done
