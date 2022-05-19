#!/bin/bash

# This script is still in the early stages. 
# It's functional, but it's missing many features (such as certificate selection).
# It is also bound to the devcontainer, since it needs some VOMS dependencies.
#



echo "Starting requester..."
role="";
operation=""
defaultJWT="eyJraWQiOiJyc2ExIiwiYWxnIjoiUlMyNTYifQ.eyJ3bGNnLnZlciI6IjEuMCIsInN1YiI6IjI0NjkwN2YzLWIzZDMtNDU5MC04MWRiLTg5M2FiOTA3YjVkOSIsImF1ZCI6Imh0dHBzOlwvXC93bGNnLmNlcm4uY2hcL2p3dFwvdjFcL2FueSIsIm5iZiI6MTY0ODczMDQxNCwic2NvcGUiOiJ3bGNnLmdyb3VwcyIsImlzcyI6Imh0dHBzOlwvXC9pYW0tZGV2LmNsb3VkLmNuYWYuaW5mbi5pdFwvIiwiZXhwIjoxNjQ4NzM0MDE0LCJpYXQiOjE2NDg3MzA0MTQsImp0aSI6ImQyZDZmMWI5LWFmYTMtNGIyYi05NDlhLThjMzFlNjVmMmQ2OCIsImNsaWVudF9pZCI6ImVkYzU0Y2FkLTZlYjgtNGY2Ni04OTFjLTQzMTg4ZTZlZjk4NiIsIndsY2cuZ3JvdXBzIjpbIlwvZGV2Il19.XKrsDRe8ZGbGomgthKv0njgUnzbSNMYOy_A9_1C-J9TR1T5lpOXu446oi-VJkiIBMsoLjdvDEZit2pW-xjlGSVkjF1bxQnUOs5YSAA24QRdmPNT7f-4vqqn7NNxZB8Ox4um_BrTHpjurf-BTb5Gc87hEa44t0cmbvXckw7n1o5k"


if [ "$1" == "--voms" ]; then 
    echo "Enabled VOMS certificate authorization (You'll need to activate the docker container in order to use it)"
    curl --cert "/tmp/x509up_u1000"  --capath "/etc/grid-security/certificates"  --cacert "../nginx_docker_revproxy/certificates_for_https/user.cert.pem" "https://pippocnaf.test.example:8081/" 
    exit 1
elif [ "$1" == "-t" ]; then 
    echo "JWT enabled and set to default value"
    curl -X "POST" "https://pippocnaf.test.example:8081/operation/" -H "Authorization: $defaultJWT" -H "X-EnableJWT: true" 
    exit 1
elif [ -z "$1" ]; then
    echo "you must input an operation for this to work"
    exit 1
else 
    operation="$1"
fi

if [ -z "$2" ]; then
     echo "you must input a role for this to work (or enable the JWT or VOMS)"
     exit 1
else
    role="$2"
fi

curl --cacert "../nginx_docker_revproxy/certificates_for_https/igi-test-ca.pem" -X "POST" "https://pippocnaf.test.example:8081/operation/" -H "X-Role: $1" -H "X-Operation: $2" -H "X-EnableJWT: false" 
exit 1