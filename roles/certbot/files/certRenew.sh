touch /var/log/renewcert.log
certbot -q renew --pre-hook "service nginx stop" --post-hook "service nginx start">> /var/log/renewcert.log 2>&1
