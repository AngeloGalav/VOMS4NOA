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


You'll then need to add the `servicecnaf.test.example` host into `/etc/hosts` of your PC: 
```
127.0.0.1  localhost servicecnaf.test.example
``` 

Subsequently, the NGINX-OPA-Authz infrastructure must be booted using another terminal:
```bash
docker-compose up
```

This final steps will allow you to actually test the infrastructure we just built (keep in mind that you mustn't exit the `.devcontainer`):
```bash
./debug_requester/voms_curl_test.sh [role] [operation]
```
If the `debug_tester` is not working, you can still use the `curl` to try and test this system. Here are some examples:
- Using a VOMS Proxy (this command must be executed inside the devcontainer in order to use the VOMS Proxy). 
```
curl --cert "/tmp/x509up_u1000"  --capath "/etc/grid-security/certificates"  --cacert "nginx_docker_revproxy/certificates_for_https/user.cert.pem" "https://servicecnaf.test.example:8081/operation/" -H "X-Operation: retrieve" -H "X-EnableJWT: false" 
```

- Using simple authentication information 
```
curl  --capath "/etc/grid-security/certificates"  "https://servicecnaf.test.example:8081/operation/" -H "X-Role: moderator" -H "X-Operation: report" -H "X-EnableJWT: false"
```

<!-- Aggiungere parte dei metodi di accesso disponibili, aka JWT e VOMS, e come usarli in modo interchangeable -->

## IN-&-OUTS of a VOMS Proxy

A VOMS Proxy is a certificate used by the The Virtual Organization Membership Service, which enables Virtual Organization access control in distributed services. 
You can find more information about VOMS [here](https://italiangrid.github.io/voms/).

The VOMS Proxy is made of 2 parts:
- The user certificate, which is a standard x509 certificate.
- The VOMS AC (Attribute Certificate), which is a x509 certificate representing the VO. 

Both parts are standard X509 certificates and can be used for SSL connections.

The server validating the VOMS Proxy will need to check both the user certificate and the VOMS AC. It will also need the standard X509 user certificate, in order to fill the Certificate Chain.  

## Milestones & Todos
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
- [x] Fix known issues
- [ ] Enhancing devcontainer with oidc agent token definition
- [ ] Measure performance of the whole system and draw conclusions
- [ ] Enhancing bash scripts for interactions/debugging

## Notes
The service server graphical UI also is not supported anymore. It is suggested to use `debug_requester` for further testing and interacting with the system.