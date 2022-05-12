curl -k --cert "../voms-client/certs/x509up_u1000" --key "../voms-client/certs/x509up_u1000" --cacert "../voms-client/certs/user.cert.pem" --capath "../nginx"  "https://pippocnaf.test.example:8081/" 

# curl --cert "/tmp/x509up_u1000" --key "/tmp/x509up_u1000"  --capath "/etc/grid-security/certificates"  "https://pippocnaf.test.example:8081/"

# comandi provati:
# curl --cert "/tmp/x509up_u1000"  --capath "/etc/grid-security/certificates"  --cacert "voms-client/certs/user.cert.pem" "https://pippocnaf.test.example:8081/" 
# curl --cert "/tmp/x509up_u1000"  --capath "/etc/grid-security/certificates"  "https://pippocnaf.test.example:8081/" 
# (quest'ultimo provato siccome il proxy voms contiene il certificato dell'utente)