# WARNING!!! These commands are meant to be used in the devcontainer enviroment. 
# If you run them on your machine, it wont be able to find the certificates properly.

curl --cert "/tmp/x509up_u1000"  --capath "/etc/grid-security/certificates"  --cacert "nginx_docker_revproxy/certificates_for_https/user.cert.pem" "https://storm-tape.test.example:8081/operation/" -H "X-Role: $1" -H "X-Operation: $2" -H "X-EnableJWT: false" 
#`ricordati di creare il proxy VOMS con il comando:
# voms-proxy-init -pwstdin -voms test.vo <<< pass
