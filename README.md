# VOMS4NOA - Storm-Tape API branch

Proxy VOMS Integration for the OpenResty-OPA reverse proxy infrstructure, thus enabling usage, testing and validation of VOMS Certificates. 

Development is still in progress.

## Usage

First of all, you'll need to generate a Proxy VOMS using `voms-proxy-init`. To do that, you'll need to enter the `.devcontainer`, which provides easy use to the VOMS services. You can use the `.devcontainer` inside Visual Studio Code by clicking on the icon in the bottom left with the two angled brackets and selecting "Reopen Folder in Container".

After entering the container, you'll need to create said Proxy VOMS:
```bash
voms-proxy-init -pwstdin -voms test.vo <<< pass
```

(You can also create a VOMS proxy using the voms-client container. You can find more info about the voms-client below, but I suggest to stick with the devcontainer).


You'll then need to add the `storm-tape.test.example` host into `/etc/hosts` of your PC: 
```
127.0.0.1  localhost storm-tape.test.example
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
curl --cert "/tmp/x509up_u1000"  --capath "/etc/grid-security/certificates"  --cacert "nginx_docker_revproxy/certificates_for_https/user.cert.pem" "https://storm-tape.test.example:8081/operation/" -H "X-Operation: retrieve" -H "X-EnableJWT: false" 
```

- Using simple authentication information 
```
curl  --capath "/etc/grid-security/certificates"  "https://storm-tape.test.example:8081/operation/" -H "X-Role: moderator" -H "X-Operation: report" -H "X-EnableJWT: false"
```

<!-- Aggiungere parte dei metodi di accesso disponibili, aka JWT e VOMS, e come usarli in modo interchangeable -->

## Storm-Tape API Commands

You can use the `storm-tape-debug` tool in the `debug-requester` folder. 
Either way, here are some of the commands you can use to interact with the whole system:
- staging a request
```
curl -i -d @storm-tape-data/stage_request.json http://localhost:8080/api/v1/stage
```
- progress tracking
```
curl -i http://localhost:8080/api/v1/stage/6aa34070-d82c-49c5-b4c1-f48046625d2f
```
- See archive information (info of the files stored) 
```
curl -i -d @storm-tape-data/archive_info.json http://localhost:8080/api/v1/archiveinfo
```
- Delete a stage request
```
curl -X "DELETE" -i http://localhost:8080/api/v1/stage/6aa34070-d82c-49c5-b4c1-f48046625d2f
```

## About Storm-Tape
(coming soon...)