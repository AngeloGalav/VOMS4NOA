# rm -rf certs/*
docker build -t voms-client .
docker run --rm -it --name voms-test-client \
 --mount type=bind,source="$(pwd)"/certs,target=/tmp voms-client 
# docker exec voms-test-client "voms-proxy-init -pwstdin -voms test.vo <<< pass"