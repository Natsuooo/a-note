# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://a-note.lgraph.net"

SitemapGenerator::Sitemap.create do
  Micropost.find_each do |micropost|
    add micropost_path(micropost), :lastmod => micropost.updated_at
  end
  
  User.find_each do |user|
    add user_path(user), :lastmod => user.updated_at
  end
end