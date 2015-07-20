require 'thor'
# require 'liveblink/cli/fav'
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

    spec = Gem::Specification.find_by_name("liveblink")
    gem_root = spec.gem_dir
    gem_lib = gem_root + "/lib"

    @@fav_path = gem_lib + "/liveblink/cli/favorites.txt"

    desc "init", "Initializes a favorites list, stored as a text file."
    def init
      if !(File.file?(@@fav_path))
        fav_file = File.new(@@fav_path, "w")
        fav_file.close
        puts "Creating favorites file"
      else
        puts "Favorites file already exists"
      end
    end

      #favorites
      desc "list", "Displays favorites list"
      method_option :online, :aliases => "-o", :desc => "Lists only streams that are online"
      def list
        online = options[:online]
        if File.file?(@@fav_path)
          if online
            Helper.get_online_favs
          else 
            puts File.read(@@fav_path)
          end
        else
          puts "No favorites file found. Use the init command to create one."
        end
      end

      #favorites add NAME
      desc "fav add [NAME]", "Adds [NAME] to favorites list"
      def add(name)
        open(@@fav_path, 'a') { |f|
          f.puts name
        }
        puts "Added #{name}"
      end

      #favorites delete NAME
      desc "fav delete [NAME]", "Deletes [NAME] from favorites list"
      def delete(name)

        # Open temporary file
        tmp = Tempfile.new("extract")

        # Write good lines to temporary file
        open(@@fav_path, 'r').each { |l| tmp << l unless l.chomp == name }

        # Close tmp, or troubles ahead
        tmp.close

        # Move temp file to origin
        FileUtils.mv(tmp.path, @@fav_path)
        puts "Deleted #{name}"
      end

      desc "fav clear", "Completely clears favorites list"
      def clear
        answer = ask ("Deleting favorites file, are you sure? (Y/N).")
        answer.downcase
        if answer == 'yes' || answer ==  'y'
          if File.file?(@@fav_path)
            FileUtils.rm(@@fav_path)
            puts "Favorites file deleted."
            exec "figlet IT FUCKING WORKS BABY YEAH"
          else
            puts "No favorites file detected."
            puts "Deletion aborted"
          end
        else
          puts "Deletion aborted."
        end
      end

    # Uncomment this if unmigrating from fav.rb
    # desc "fav [COMMANDS]", "Favorites control module"
    # subcommand "fav", LiveBlink::CLI::Fav


    # Uncomment this if you want to add test.rb
    # desc "test {module}", "test control module"
    # subcommand "test", LiveBlink::CLI::Test
  end
end