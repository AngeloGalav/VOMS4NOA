# VOMS4NOA

Proxy VOMS Integration for the OpenResty-OPA reverse proxy infrstructure, thus enabling usage, testing and validation of VOMS Certificates. 

Development is still in progress.

## Usage

First of all, you'll need to generate a Proxy VOMS using `voms-proxy-init`. To do that, you'll need to enter the `.devcontainer`, which provides easy use to the VOMS services. You can use the `.devcontainer` inside Visual Studio Code by clicking on the icon in the bottom left with the two angled brackets and selecting "Reopen Folder in Container".

After entering the container, you'll need to create said Proxy VOMS:
```bash
voms-proxy-init -pwstdin -voms test.vo <<< pass
```

(You can also create a VOMS proxy using the voms-client container. You can find more info about the voms-client below, but I suggest to stick with the devcontainer).


You'll then need to add the `pippocnaf.test.example` host into `/etc/hosts` of your PC: 
```
127.0.0.1  localhost pippocnaf.test.example
``` 

Subsequently, the NGINX-OPA-Authz infrastructure must be booted using another terminal:
```bash
docker-compose up
```

This final steps will allow you to actually test the infrastructure we just built (keep in mind that you mustn't exit the `.devcontainer`):
```bash
./debug_requester/simple_curl_test.sh
```

## IN-&-OUTS of a VOMS Proxy

A VOMS Proxy is a certificate used by the The Virtual Organization Membership Service, which enables Virtual Organization access control in distributed services. 
You can find more information about VOMS [here](https://italiangrid.github.io/voms/).

The VOMS Proxy is made of 2 parts:
- The user certificate, which is a standard x509 certificate.
- The VOMS AC (Attribute Certificate), which is a x509 certificate representing the VO. 

Both parts are standard X509 certificates and can be used for SSL connections.

The server validating the VOMS Proxy will need to check both the user certificate and the VOMS AC. It will also need the standard X509 user certificate, in order to fill the Certificate Chain.  

## Compatibility with the job submission architecture @ INFN CNAF

This system relies on the CMS/DN association using the server filesystem. Essentially:
- After the user has been authorized, an {DN, FQANS} pair is associated within a cms of the respective FQANS cms pool. You could interpret FQANS as being essentially a group name. 
- We then associate the DN with the respective pool-uid of the CMS, by making an hard link to the cms file. This way the access is kept atomic. 

This part of the project is now the main focus, but it still very much in the concept process.


## Milestones
Through the [NGINX-OPA-Authz](https://github.com/AngeloGalav/NGINX-OPA-Authz) repository:
- [x] Understading OPA
- [x] Making a simple RBAC in OPA
- [x] Adding support for JWT
- [x] Developing a RevProxy using NGINX and Docker-compose
- [x] Integrating the RevProxy with OPA
- [x] Ditching the sidecar in favour of NJS for authorization information parsing
- [x] Developing a way to interact with this system
- [x] Adding support for X509 certificates

Through this repository:
- [x] Understanding VOMS Proxies and how they work
- [x] Adding VOMS support to the OpenResty revproxy
- [x] Easing the VOMS creation process (.devcontainer integration)
- [x] Adding VOMS support in OPA
- [ ] Fully integrate the .devcontainer inside the whole infrastructure (built with docker-compose)    
- [ ] Enhancing OPA policies
- [ ] Enhancing the OPA "database"
- [ ] Enhancing bash scripts for interactions/debugging
- [ ] Designing mapping system / job submission system (?)

## Known Issues and future developments

As of the right now, the whole system does not allow for easy testing. The data that OPA uses must be modified in other to notice a real change of status. An overhaul of the data used by OPA and, in general, its policies is needed.  

The service server UI also does not work anymore, but we're still deciding if we're going to keep it and/or maintaining it, since the most convenient way of interacting with the system is through the `debug_requester`.

Also, further development of the NGINX configuration is needed to support seamless compatibility between JWT, VOMS and no_cert mode. 