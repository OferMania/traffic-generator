# trex-local

Run `./dev-env`

# To setup a standard communication container

In a different console outside of the Docker container, run `./dual_containers.sh`

From outside trex container you can do:
> sudo ip netns exec sleeper wireshark

From inside the container:
> ./t-rex-64 -f cap2/dns.yaml -c 1 -m 1 -d 10

# To get Trex to ping

From within the container:
> ./t-rex-64 -i

From a second window (via `docker exec -it trex bash`):
> ./trex-console
> service
> ping -p 0 -d 1.1.1.2

# To setup a VLAN tagged communication container

Outside of the docker container, instead of running `./dual_containers.sh`, run 
`./vlan_container.sh`

Within the container, instead of running `./t-rex-64 -i` you will need to run:
> ./t-rex-64 -i --cfg cfg/vlan_cfg.yaml

All other steps should remain the same. Note that within the trex-console within the container, 
after you've setup service mode, you can send a ping tagged with vlan by doing this:

`ping -p 0 -d 1.1.1.2 --vlan 24`

However, the sleeper container would need to be configured to generate a reply for VLAN tagged
packets. At the moment, it isn't...
