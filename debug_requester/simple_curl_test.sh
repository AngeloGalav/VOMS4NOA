# WARNING!!! These commands are meant to be used in the devcontainer enviroment. 
# If you run them on your machine, it wont be able to find the certificates properly.

curl --cert "/tmp/x509up_u1000"  --capath "/etc/grid-security/certificates"  --cacert "nginx_docker_revproxy/certificates_for_https/user.cert.pem" "https://pippocnaf.test.example:8081/"
#`ricordati di creare il proxy VOMS con il comando:
# voms-proxy-init -pwstdin -voms test.vo <<< pass
