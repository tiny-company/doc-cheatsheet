# nginx basics

## Description

Find here basic information about how nginx works.

### Main top-level configuration block in Nginx

In Nginx configuration, `upstream`, `server`, and `http` are directives that serve different purposes. Let's break down the differences between them:

1. **http:**
   - The `http` block is the top-level configuration block in Nginx.
   - It contains directives that are applied globally to the entire server, such as settings related to logging, timeouts, and other general configurations.
   - You can also define default values for various settings within the `http` block.

   Example:
   ```nginx
   http {
       # Global configurations
       log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                     '$status $body_bytes_sent "$http_referer" '
                     '"$http_user_agent" "$http_x_forwarded_for"';

       sendfile on;
       tcp_nopush on;
       tcp_nodelay on;
       keepalive_timeout 65;

       # Other settings...

       # Include additional configuration files
       include /etc/nginx/conf.d/*.conf;
   }
   ```

2. **server:**
   - The `server` block is used to define the configuration for a specific virtual server or a server listening on a particular IP address and port.
   - Multiple `server` blocks can exist within an `http` block, allowing you to configure different virtual hosts or server setups.
   - Each `server` block contains configurations related to that specific server, such as the server name, document root, and SSL settings.

   Example:
   ```nginx
   server {
       listen 80;
       server_name example.com www.example.com;
       root /var/www/html;

       location / {
           # Configurations for handling requests in this location
       }

       # SSL configurations, additional locations, etc.
   }
   ```

3. **upstream:**
   - The `upstream` block is used for defining groups of servers that can handle a particular type of request, typically for load balancing and failover purposes.
   - It is not used at the server level like the `server` block but is typically placed within the `http` block.
   - The `upstream` block contains a list of `server` directives representing individual backend servers.

   Example:
   ```nginx
   http {
       upstream my_backend {
           server backend1.example.com;
           server backend2.example.com;
           server backend3.example.com;
       }

       server {
           listen 80;
           server_name example.com;

           location / {
               proxy_pass http://my_backend;
           }
       }
   }
   ```

In summary, `http` contains global configurations, `server` is used to define settings for a specific virtual server, and `upstream` is used to define groups of servers for load balancing within the `http` block. Each plays a different role in organizing and configuring Nginx based on the desired architecture and requirements.

## Sources :

- [official nginx documentation](https://nginx.org/en/docs/)