# docker image
FROM sameersbn/gitlab:10.3.3

# maintainer information
MAINTAINER ayapapa ayapapajapan@yahoo.co.jp

# fix some issues related to relative resources(avatar, uploads)' url
RUN \
    ABSROOT="Gitlab\.config\.gitlab\.url" && \
    RELROOT="Gitlab\.config\.gitlab\.relative_url_root" && \
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
    TARGET="${ABSROOT}" && \
    REPLACE="${RELROOT}" && \
    sed -i.org  "s/${TARGET}/${REPLACE}/" \
        /home/git/gitlab/lib/banzai/filter/upload_link_filter.rb
