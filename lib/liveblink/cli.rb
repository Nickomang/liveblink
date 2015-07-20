require 'thor'
require 'liveblink/cli/fav'
# require 'liveblink/cli/test'

module LiveBlink
  class Wrapper < Thor
    # make quality optional
    # change watch to just be nameless

    desc "watch [STREAM_NAME] [QUALITY]", "Watches stream associated with url"
    option :scrub
    def watch (url, quality)
      twitch = "http://www.twitch.tv/#{url}"
      string = "livestreamer #{twitch} #{quality}"
      if options[:scrub]
        string += " scrub_string"
      end
      system string
    end
    default_task :watch

    desc "fav [COMMANDS]", "Favorites control module"
    subcommand "fav", LiveBlink::CLI::Fav

    # desc "test {module}", "test control module"
    # subcommand "test", LiveBlink::CLI::Test
  end
end