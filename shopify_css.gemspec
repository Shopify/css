$:.push File.expand_path("../lib", __FILE__)

require "shopify_css/version"

Gem::Specification.new do |s|
  s.name = "shopify_css"
  s.platform = Gem::Platform::RUBY
  s.version = ShopifyCSS::VERSION
  s.authors = ["Shopify"]
  s.email = ["info@shopify.com"]
  s.homepage = "http://www.shopify.com"
  s.summary = `git log -1`.split(/\n/)[0][7..-1].to_s
  s.description = "Shopify's css guide and linting setup"

  s.files = Dir["{lib}/**/*", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "scss_lint", ">= 0.50.0"
  s.add_dependency "rake"
end
