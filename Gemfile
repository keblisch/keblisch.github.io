source "https://rubygems.org"

gem "github-pages", group: :jekyll_plugins
gem "just-the-docs"

platforms :windows, :jruby do
    gem "tzinfo", ">= 1", "< 3"
    gem "tzinfo-data"
    gem "wdm", "~> 0.1.0"
    gem "http_parser.rb", "~> 0.6.0", platforms: [:jruby]
end

group :jekyll_plugins do
  gem "jekyll-sitemap"
  gem "jekyll-seo-tag"
end
