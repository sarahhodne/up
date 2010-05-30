require 'sdoc'
require 'rake/rdoctask'

#
# Helpers
#

def command?(command)
  system("type #{command} > /dev/null")
end


#
# Ronn
#

if command? :ronn
  desc "Show the manual"
  task :man => "man:build" do
    exec "man man/mustache.1"
  end

  desc "Build the manual"
  task "man:build" do
    sh "ronn -br5 --organization=DVYJONES --manual='Up Manual' man/*.ronn"
  end
end


#
# Gems
#

desc "Push a new version to Gemcutter and publish docs."
task :publish do
  require File.dirname(__FILE__) + '/lib/up/version'

  system "git tag v#{Up::Version}"
  sh "gem build up.gemspec"
  sh "gem push up-#{Up::Version}.gem"
  sh "git push origin master --tags"
  sh "git clean -fd"
  exec "rake pages"
end


#
# Documentation
#

Rake::RDocTask.new do |rdoc|
  rdoc.main = 'README.md'
  rdoc.rdoc_files = [ 'README.md', 'LICENSE', 'lib' ]
  rdoc.rdoc_dir = 'docs'
end

namespace :pages do
  task :publish => [ :check_dirty, "man:build", :rerdoc ] do
    `git checkout gh-pages`
    `ls -1 | grep -v docs | grep -v man | xargs rm -rf`
    `git add .; git commit -m "update docs"; git push origin gh-pages`
    `git checkout master`
    puts :done
  end

  task :check_dirty do
    if !`git status`.include?('nothing to commit')
      abort "dirty index - not publishing!"
    end
  end
end

desc "Build and publish documentation using GitHub Pages."
task :pages => "pages:publish"

