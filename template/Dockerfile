# docker image
FROM sameersbn/gitlab:{{VERSION}}

# maintainer information
MAINTAINER ayapapa ayapapajapan@yahoo.co.jp

# fix some issues related to relative resources(avatar, uploads)' url
RUN \
    ABSROOT="Gitlab\.config\.gitlab\.url" && \
    RELROOT="Gitlab\.config\.gitlab\.relative_url_root" && \
    TARGET="\[gitlab_config\.url, avatar\.url\]\.join" && \
    REPLACE="\[${RELROOT}, avatar\.url\]\.join" && \
    sed -i.org "s/${TARGET}/${REPLACE}/" \
      /home/git/gitlab/app/models/group.rb \
      /home/git/gitlab/app/models/project.rb \
      /home/git/gitlab/app/models/user.rb && \
    \
    TARGET="return if html_attr\.value\.start_with?('\/\/')" && \
    REPLACE="\        return if html_attr.value.start_with?(Gitlab.config.gitlab.relative_url_root) && File.dirname(File.dirname(html_attr.value)).end_with?('uploads')" && \
    sed -i.org "/${TARGET}/a ${REPLACE}" \
        /home/git/gitlab/lib/banzai/filter/relative_link_filter.rb && \
    \
    TARGET="def apply_relative_link_rules\!" && \
    REPLACE="\          return if \@uri\.to_s\.start_with?(${RELROOT})" && \
    sed -i.org "/${TARGET}/a ${REPLACE}" \
        /home/git/gitlab/lib/banzai/filter/wiki_link_filter/rewriter.rb && \
    \
    TARGET="File\.join(${ABSROOT}, project\.path_with_namespace, uri)" && \
    REPLACE="File\.join(${RELROOT}, project\.path_with_namespace, uri)" && \
    sed -i.org  "s/${TARGET}/${REPLACE}/" \
        /home/git/gitlab/lib/banzai/filter/upload_link_filter.rb && \
    \
    TARGET="File\.join(context\[:asset_root\], url_to_image(emoji_path))" && \
    REPLACE="url_to_image(emoji_path)" && \
    sed -i.org "s/${TARGET}/${REPLACE}/" \
        /home/git/gitlab/lib/banzai/filter/emoji_filter.rb
