# docker image
FROM sameersbn/gitlab:8.17.0

# maintainer information
MAINTAINER ayapapa ayapapajapan@yahoo.co.jp

# fix some issues related to relative resources(avatar, uploads)' url
RUN sed -i.org \
      "s/\[gitlab_config\.url, avatar\.url\]\.join/\[Gitlab\.config\.gitlab\.relative_url_root, avatar\.url\]\.join/" \
      /home/git/gitlab/app/models/group.rb /home/git/gitlab/app/models/project.rb /home/git/gitlab/app/models/user.rb && \
    sed -i.org \
      "s/return if html_attr\.value\.start_with?('\/\/')/return if html_attr\.value\.start_with?('\/\/')\n        return if html_attr\.value\.start_with?(Gitlab\.config\.gitlab\.relative_url_root)/" \
      /home/git/gitlab/lib/banzai/filter/relative_link_filter.rb && \
    sed -i.org \
      "s/def apply_relative_link_rules\!/def apply_relative_link_rules\!\n          return if \@uri\.to_s\.start_with?(Gitlab\.config\.gitlab\.relative_url_root)/" \
      /home/git/gitlab/lib/banzai/filter/wiki_link_filter/rewriter.rb && \
    sed -i.org \
      "s/File\.join(Gitlab\.config\.gitlab\.url, project\.path_with_namespace, uri)/File\.join(Gitlab\.config\.gitlab\.relative_url_root, project\.path_with_namespace, uri)/" \
      /home/git/gitlab/lib/banzai/filter/upload_link_filter.rb && \
    sed -i.org \
      "s/File\.join(context\[:asset_root\], url_to_image(emoji_path))/url_to_image(emoji_path)/" \
      /home/git/gitlab/lib/banzai/filter/emoji_filter.rb

