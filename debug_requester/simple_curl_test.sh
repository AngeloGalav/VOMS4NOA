curl --cacert "../nginx_docker_revproxy/certificates_for_https/igi-test-ca.pem" -X "POST" "https://pippocnaf.test.example:8081/operation/" -H "X-Role: $1" -H "X-Operation: $2" -H "X-EnableJWT: false" 

