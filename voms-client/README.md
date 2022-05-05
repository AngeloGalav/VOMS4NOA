# VOMS client

This is the client that lets you generate VOMS Proxy certificates used for testing.
Essentially, this is what enables us to test the VOMS module of OpenResty properly.

To run the docker image, use the provided bash script `docker_cmds.sh`. 
After the docker image has run, you'll need to run the command:
```bash
voms-proxy-init -pwstdin -voms test.vo <<< pass
```
In order to generate the voms-proxy certificate. 
The certificate can be found @ the file `./certs/x509up_u1000`. 