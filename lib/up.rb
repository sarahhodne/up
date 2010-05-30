require 'rack'

class Up
  def self.detect_rack_handler(server)
    servers = server.split(',')
    servers.each do |server_name|
      begin
        return Rack::Handler.get(server_name.downcase)
      rescue LoadError
      rescue NameError
      end
    end
    fail "Server handler (#{servers.join(',')}) not found."
  end

  class Application
    def self.quit!(server)
      ## Use thins' hard #stop! if available, otherwise just #stop
      server.respond_to?(:stop!) ? server.stop! : server.stop
      puts "\n== Up has stopped"
    end

    def self.new(dir)
      Rack::Builder.new do
        run Rack::Directory.new(dir)
      end
    end
  end
end
