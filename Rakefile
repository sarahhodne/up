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
  require File.dirname(__FILE__) + '/lib/mustache/version'

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

begin
  require 'sdoc_helpers'
rescue LoadError
  warn "sdoc support not enabled. Please gem install sdoc-helpers."
end
