server {
       listen   443; ## listen for ipv4; this line is default and implied
       ssl on;
       #ssl_certificate         /home/ubuntu/conlana/16cfd91eee3ca2f1.crt;
       ssl_certificate         /etc/ssl/conlana-io.com/16cfd91eee3ca2f1.crt;
       ssl_certificate_key     /etc/ssl/conlana-io.com/conlana-io.com.key;
       #listen   [::]:80 default ipv6only=on; ## listen for ipv6

       #root /var/www/;
       #index index.html index.htm;

       # Make site accessible from http://localhost/
       server_name conlana-io.com;

       location / {
            proxy_pass http://conlana-io.com:1337/;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_set_header Host $host;
       }
}
