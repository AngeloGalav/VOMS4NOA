# VOMS4NOA

Proxy VOMS Integration for the OpenResty-OPA reverse proxy infrstructure, thus enabling usage, testing and validation of VOMS Certificates. 

Development is still in progress.

# Usage

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


# IN-&-OUTS of a VOMS Proxy

A VOMS Proxy is a certificate used by the The Virtual Organization Membership Service, which enables Virtual Organization access control in distributed services. 
You can find more information about VOMS [here](https://italiangrid.github.io/voms/).

The VOMS Proxy is made of 2 parts:
- The user certificate, which is a standard x509 certificate.
- The VOMS AC (Attribute Certificate), which is a x509 certificate representing the VO. 

Both parts are standard X509 certificates and can be used for SSL connections.

The server validating the VOMS Proxy will need to check both the user certificate and the VOMS AC. It will also need the standard X509 user certificate, in order to fill the Certificate Chain.  