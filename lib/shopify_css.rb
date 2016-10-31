module ShopifyCSS
  def self.root
    @root ||= Pathname.new(File.dirname(File.expand_path('..', __FILE__)))
  end

  def self.lint_config
    ShopifyCSS.root.join('.scss-lint.yml').to_s
  end
end
