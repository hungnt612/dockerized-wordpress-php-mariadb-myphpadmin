Docker running PHP-FPM, PHPMyAdmin, Mariadb, Wordpress, Nginx [`Optional`], Composer [`Optional`], MySQL [`Optional`].

## Install prerequisites

To run the docker commands without using **sudo** you must add the **docker** group to **your-user**:

```
sudo usermod -aG docker your-user
```

For now, this project has been mainly created for Unix `(Linux/MacOS)`. Perhaps it could work on Windows.

All requisites should be available for your distribution. The most important are :

- [Git](https://git-scm.com/downloads)
- [Docker](https://docs.docker.com/engine/installation/)
- [Docker Compose](https://docs.docker.com/compose/install/)

Check if `docker-compose` is already installed by entering the following command :

```sh
which docker-compose
```

Check Docker Compose compatibility :

- [Compose file version 3 reference](https://docs.docker.com/compose/compose-file/)

The following is optional but makes life more enjoyable :

```sh
which make
```

On Ubuntu and Debian these are available in the meta-package build-essential. On other distributions, you may need to install the GNU C++ compiler separately.

```sh
sudo apt install build-essential
```

### Config

This project use the following ports :

| Server     | Port |
| ---------- | ---- |
| Mariadb    | 3306 |
| Wordpress  | 8866 |
| MySQL      | 8989 |
| PHPMyAdmin | 8080 |
| Nginx      | 8000 |
| Nginx SSL  | 3000 |

---

### Project tree

```sh
.

├── README.md
├── mariadb_data
├── docker-compose.yml
├── etc
   ├── nginx
   │   ├── default.conf
   │   └── default.template.conf
   ├── php
   │   └── php.ini
   └── ssl
```

---

## Configure Nginx With SSL Certificates [`Optional`]

You can change the host name by editing the `.env` file.

If you modify the host name, do not forget to add it to the `/etc/hosts` file.

1. Generate SSL certificates

   ```sh
   source .env && docker run --rm -v $(pwd)/etc/ssl:/certificates -e "SERVER=$NGINX_HOST" jacoelho/generate-certificate
   ```

2. Configure Nginx

- [Generate Certificate](https://hub.docker.com/r/jacoelho/generate-certificate/)

  Do not modify the `etc/nginx/default.conf` file, it is overwritten by `etc/nginx/default.template.conf`

  Edit nginx file `etc/nginx/default.template.conf` and uncomment the SSL server section :

  ```sh
  # server {
  #     server_name ${NGINX_HOST};
  #
  #     listen 443 ssl;
  #     fastcgi_param HTTPS on;
  #     ...
  # }
  ```

---
