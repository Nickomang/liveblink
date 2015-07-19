require 'thor'
require 'liveblink/cli/fav'

module LiveBlink
  class Wrapper < Thor
    desc "hello NAME", "This will greet you"
    long_desc <<-HELLO_WORLD

    `hello NAME` will print out a message to the person of your choosing.

    Brian Kernighan actually wrote the first "Hello, World!" program 
    as part of the documentation for the BCPL programming language 
    developed by Martin Richards. BCPL was used while C was being 
    developed at Bell Labs a few years before the publication of 
    Kernighan and Ritchie's C book in 1972.

    http://stackoverflow.com/a/12785204
    HELLO_WORLD
    option :upcase
    def hello( name )
      greeting = "Hello, #{name}"
      greeting.upcase! if options[:upcase]
      puts greeting
    end

    desc "watch [STREAM_NAME]", "Watches stream associated with url"
    def watch (url)
      twitch = "http://www.twitch.tv/#{url}"
      string = "livestreamer #{twitch} best"
      puts string
    end


    desc "fav [COMMANDS]", "Favorites control module"
    subcommand "fav", LiveBlink::CLI::Fav
  end
end