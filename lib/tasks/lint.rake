namespace :css do
  desc 'Lint SCSS in your project'
  task :lint do
    require 'scss_lint/rake_task'
    SCSSLint::RakeTask.new do |t|
      t.config = ShopifyCSS.lint_config
      t.files = ['app/assets/stylesheets']
    end
    Rake::Task[:scss_lint].invoke
  end
end
