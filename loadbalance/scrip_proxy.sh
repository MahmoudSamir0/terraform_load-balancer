#!/bin/bash
"sudo apt-get update -y",
"sudo apt install nginx -y",
"sudo echo 'server { \n listen 80 default_server; \n  listen [::]:80 default_server; \n  server_name _; \n  location / { \n  proxy_pass http://${module.load.load_pri_arn}; \n  } \n}' > /etc/nginx/sites-enabled/default",
"sudo service nginx reload"
