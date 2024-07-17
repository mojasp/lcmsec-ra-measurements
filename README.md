# Startup latency measurement of LCMsec RA protocol

## Goals

* Measure startup latency of LCMsec. More precicely, disregard the discovery phase and measure startup latency of GKA+Attestation
* 
## technical considerations

* We are running many nodes on one machine => its easy to overflow buffers or overload CPU since we are on a broadcast topology. So we cannot run more than ~40 nodes on one machine. The limit of active nodes in the DB GKA / RA seems to be about 25.
* For the same reason timeouts in the discovery phase are increased (ensure discovery doesn't time out).

## Instructions for use / overview of the files in this directory
* You need one normal build of LCmsec as well as one tracy-enabled build. To produce the later, configure LCMSec to use tracy with `cmake -DUSE_TRACY=ON [...]`. You also need the tracy-csvexport and tracy-capture binaries which can be built from source (tracy-src/capture and tracy-src/csvexport). For me, there were some errors during the build; if that is the case set -DNO_PARALLEL_STL=1 and D_LEGACY=1 when configuring.
* run_test.py runs a single instance of the protocol. it takes as arguments: joining(size of J), run(only needed for the name of the output file), directory(where to place output files), and preexisting (size of P) as cmd-parameters
* edit run_test.py to include the path of both LCMsec builds as well as the location of the tracy binary
* gen_certificates.py generates the PKI that is needed to run LCMSec; you need to run this befor running the measurements
* gen_instances.sh generates the needed config files (need a different one for each instance). it uses sed, adjust the template_instance.toml file as needed for changes. You also need to run this one first.
* run_all.py runs many runs of run_test for varying parameters, adjust as needed. For instance, P in {0,5,10,15,20} where used while increasing J from 0 to 15
* finally, analysis.r to analyse the resulting .csv files and produce a graph
* run_all.py will create folder name for test results and simlink "latest_run" to that result.
* all the files from lcm/examples/cpp_security are present: the demo_instance from there is just copied here for to serve as an actual program to be run. Its behaviour is not relevant. Some files are superflouus; i haven't cleaned it up.

## NOTES

* To emulate network delays:
    1. add loopback multicast route: sudo ifconfig lo 127.0.0.1 netmask 224.0.0.0 up 
    2. add delay: sudo tc qdisc add dev lo root netem delay 20ms for a delay of 20ms
