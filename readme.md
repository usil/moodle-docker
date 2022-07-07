# Moodle with Docker

Last moodle version 3.11.2+ (Build: 20210902) with docker

![](https://moodle.org/theme/image.php/moodleorg/theme_moodleorg/1656608410/moodle_logo_small)

---
## Configuration


|variable|sample value|description|
|--|--|--|
|MOODLE_URL|https://moodle.acme.com | base url to be used. Could be ip:port, localhost, http or https domain|
|MOODLE_SSLPROXY|true/false| Disable SSL proxy to avod site loop. Ej. Cloudfare, Huawei kubernetes balancer|
|MOODLE_REVERSE_PROXY|true/false| If a reverse proxy is used|
|MYSQL_HOST|10.20.30.40| mysql database host|
|MYSQL_PORT|3306| mysql database port|
|MYSQL_DB|my_school| mysql database name|
|MYSQL_USER|usr_moodle_admin| mysql database user|
|MYSQL_USER_PASSWORD|changeme| mysql database password|
|MOODLE_CRON_RUNNER|true/false| mysql database host|
|REDIS_HOST|50.60.70.80| redis host|
|REDIS_PORT|6379| redis port|
|REDIS_PASSWORD|secret| redis password. Null if auth is noy configured|

---
## Quickly run

```
bash one_click.sh
```

To more advanced configurations, check the [wiki](https://github.com/usil/moodle-docker/wiki/Advanced-startup)

---
## Access

Go to `http://localhost` or public domain and enter these credentials:

- admin
- bp7cHDYwVBAZz4p#

**NOTE: DON'T FORGET TO CHANGE THESE CREDENTIALS AFTER THE FIRST LOGIN**

---
You should see these pages:

![image](https://user-images.githubusercontent.com/3322836/177652730-148966a9-497b-45ea-8f8b-dc0de7307c07.png)

![image](https://user-images.githubusercontent.com/3322836/177652931-a4ff329d-4b93-4f40-b34b-21210888b492.png)

![image](https://user-images.githubusercontent.com/3322836/177653132-e83891f6-ddbe-48eb-92ed-a01053854289.png)

## Roadmap

- review
  - https://github.com/erseco/alpine-moodle
  - https://libs.garden/docker/search?q=moodle&sort=active
- more tuning parameters
- improve docs

## Contributors

|||
|:-:|:-:|
|![](https://avatars0.githubusercontent.com/u/92831091?s=100&v=4)|![](https://avatars0.githubusercontent.com/u/3322836?s=100&v=4) |
|[USIL](https://github.com/usil)|[JRichardsz](http://jrichardsz.github.io)|
