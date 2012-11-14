#!/bin/bash
for hostname
do
    echo -n | openssl s_client -connect $hostname:443 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /tmp/$hostname.cert
    certutil -d sql:$HOME/.pki/nssdb -A -t "C,," -n $hostname -i /tmp/$hostname.cert
done