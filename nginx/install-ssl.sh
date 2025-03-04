
curl https://get.acme.sh | bash

test -d /etc/nginx/ssl
/root/.acme.sh/acme.sh --issue -d test.com --webroot /opt/web/test.com/dist
/root/.acme.sh/acme.sh --installcert -d test.com --fullchain-file   /etc/nginx/ssl/test.com.pem --key-file /etc/nginx/ssl/test.com.key
