[![Licence](https://img.shields.io/npm/l/express.svg)](https://github.com/ayapapa/docker-gitlab-some-issues-fixed/edit/master/LICENSE)
[![](https://images.microbadger.com/badges/image/ayapapa/docker-gitlab.svg)](https://microbadger.com/images/ayapapa/docker-gitlab "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/ayapapa/docker-gitlab.svg)](https://microbadger.com/images/ayapapa/docker-gitlab "Get your own version badge on microbadger.com")

# docker-gitlab-some-issues-fixed
fixed some rerative url issues into sammersbn/docker-gitlab

# rerative url issues
* Paths of attachments of issues and wikis are always resolved as absolute paths using GITLAB_HOST.
  ex. in the case that GITLAB_HOST=xyz.com, when you attached abc.jpg on an issue, the attachment' path is resolved as http://xyz.com/.../abc.jpg on html
* Paths of avatars are always resolved as absolute paths using GITLAB_HOST.

# why rerative url I need
The GitLab service that I am using is made accessible via two reverse proxies.
The reason for this is due to the following background and constraints.
  1. It is necessary to manage joint projects of developers in the company and developers of cooperating companies
  2. In-house developers need to access the GitLab service from the intranet. This is to reduce the Internet access load.
  3. Developers of cooperating companies need access to the GitLab service via the Internet


