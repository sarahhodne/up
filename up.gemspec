$LOAD_PATH.unshift('lib')
require 'up/version'

Gem::Specification.new do |s|
  s.name              = "up"
  s.version           = Up::Version
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           =
      "Up is a super-simple no-frills static web server."
  s.homepage          = "http://github.com/dvyjones/up"
  s.email             = "dvyjones@binaryhex.com"
  s.authors           = [ "Henrik Hodne" ]
  s.files             = %w( README.md Rakefile LICENSE )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("bin/**/*")
  s.files            += Dir.glob("man/**/*")
  s.executables       = %w( up )
end

