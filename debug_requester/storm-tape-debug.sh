#!/bin/bash

echo "Starting requester..."
role="";
operation=""

final_command="echo 'command error'"

if [ -z "$1" ]; then
    echo "you must input a role for this to work (or enable the JWT)"
    exit 1
else 
    role="$2"
fi

if [ -z "$2" ]; then
    echo "you must input an operation for this to work"
    exit 1
else 
    operation="$1"
fi

if [ "$operation" = "stage" ]; then 
    final_command='curl -i -d @storm-tape-data/stage_request.json -k --capath "/etc/grid-security/certificates" --cacert "nginx_docker_revproxy/certificates_for_https/user.cert.pem" https://storm-tape.test.example:8081/api/v1/stage'
elif [ "$operation" = "archiveinfo" ]; then 
    final_command='curl -i -d @storm-tape-data/archive_info.json -k https://storm-tape.test.example:8081/api/v1/archiveinfo'
elif [ "$operation" = "get_progress" ]; then 
    final_command='curl -i -k https://storm-tape.test.example:8081/api/v1/stage/6aa34070-d82c-49c5-b4c1-f48046625d2f'
elif [ "$operation" = "delete" ]; then 
    final_command='curl -X "DELETE" -i -k https://storm-tape.test.example:8081/api/v1/stage/6aa34070-d82c-49c5-b4c1-f48046625d2f -k'
fi

if [ "$2" == "-t" ] || [ "$2" == "--token" ]; then 
    echo SUCAdsada
    final_command="$final_command -H 'Authorization: eyJraWQiOiJyc2ExIiwiYWxnIjoiUlMyNTYifQ.eyJ3bGNnLnZlciI6IjEuMCIsInN1YiI6IjI0NjkwN2YzLWIzZDMtNDU5MC04MWRiLTg5M2FiOTA3YjVkOSIsImF1ZCI6Imh0dHBzOlwvXC93bGNnLmNlcm4uY2hcL2p3dFwvdjFcL2FueSIsIm5iZiI6MTY0ODczMDQxNCwic2NvcGUiOiJ3bGNnLmdyb3VwcyIsImlzcyI6Imh0dHBzOlwvXC9pYW0tZGV2LmNsb3VkLmNuYWYuaW5mbi5pdFwvIiwiZXhwIjoxNjQ4NzM0MDE0LCJpYXQiOjE2NDg3MzA0MTQsImp0aSI6ImQyZDZmMWI5LWFmYTMtNGIyYi05NDlhLThjMzFlNjVmMmQ2OCIsImNsaWVudF9pZCI6ImVkYzU0Y2FkLTZlYjgtNGY2Ni04OTFjLTQzMTg4ZTZlZjk4NiIsIndsY2cuZ3JvdXBzIjpbIlwvZGV2Il19.XKrsDRe8ZGbGomgthKv0njgUnzbSNMYOy_A9_1C-J9TR1T5lpOXu446oi-VJkiIBMsoLjdvDEZit2pW-xjlGSVkjF1bxQnUOs5YSAA24QRdmPNT7f-4vqqn7NNxZB8Ox4um_BrTHpjurf-BTb5Gc87hEa44t0cmbvXckw7n1o5k' -H 'X-EnableJWT: true'"
elif [ "$2" == "--voms" ]; then
    final_command="${final_command} -H 'X-EnableJWT: false'"
else 
    role="$2"
    final_command="${final_command} -H 'X-Role: $role' -H 'X-EnableJWT: false'"
fi

eval "${final_command}"
