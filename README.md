[![Licence](https://img.shields.io/npm/l/express.svg)](https://github.com/ayapapa/docker-gitlab-some-issues-fixed/edit/master/LICENSE)
[![](https://images.microbadger.com/badges/image/ayapapa/docker-gitlab.svg)](https://microbadger.com/images/ayapapa/docker-gitlab "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/ayapapa/docker-gitlab.svg)](https://microbadger.com/images/ayapapa/docker-gitlab "Get your own version badge on microbadger.com")

# What? 
fixed some rerative url issues into sammersbn/docker-gitlab

# Rerative url issues
* Paths of attachments of issues and wikis are always resolved as **absolute paths** using GITLAB_HOST.
  ex. in the case that GITLAB_HOST=xyz.com, when you attached abc.jpg on an issue, the attachment' path is resolved as http://xyz.com/.../abc.jpg on html
* Paths of avatars are always resolved as **absolute paths** using GITLAB_HOST.
* Paths of emoji are always resolved as **absolute paths** using GITLAB_HOST.

# Why rerative url?
The GitLab service that I am using is made accessible via two reverse proxies.
The reason for this is due to the following background and constraints.
  1. It is necessary to manage joint projects of developers in the company and developers of cooperating companies
  2. In-house developers need to access the GitLab service from the intranet. This is to reduce the Internet access load.
  3. Developers of cooperating companies need access to the GitLab service via the Internet

# Prerequisites
Install docker-engine and docker compose.  
for docker-engine, see https://docs.docker.com/engine/installation/  
for docker-compose, see https://docs.docker.com/compose/ or https://github.com/docker/compose/releases

# How to use
1. clone this project
2. update docker-compose.yml if you need
3. execute ```sudo docker-compose up -d``` on the project directory.

Docker images: https://hub.docker.com/r/ayapapa/docker-gitlab/
