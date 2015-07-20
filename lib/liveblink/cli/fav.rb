require 'cathodic'
require 'highline/import'
require 'fileutils'
require 'tempfile'

module LiveBlink
	module CLI
		class Fav < Thor

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
			default_task :list

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
		end

		module Helper
			spec = Gem::Specification.find_by_name("liveblink")
			gem_root = spec.gem_dir
			gem_lib = gem_root + "/lib"

			@@fav_path = gem_lib + "/liveblink/cli/favorites.txt"

			def self.get_online_favs
				i = 0
				datas = []
				puts "These streams are online:"
				datas = self.get_datas(self.get_favs)
				datas.each do |data|
					if data.online == true
						puts data.stream_name + ', playing ' + data.game + ' (' + data.viewers.to_s + ' viewers)'
					end
				end
			end


			def self.get_favs
				links = []
				i = 0
				# File.read('../favorites.txt')
				File.foreach(@@fav_path) {
					|stream| links[i] = stream
					i += 1
				}
				return links
			end

			def self.get_datas(links)
				datas = []
				i = 0
				links.each do |link|
					links[i] = 'http://www.twitch.tv/' + link
					datas[i] = Cathodic::TwitchData.new(links[i])
					i += 1
				end
				return datas
			end
		end
	end
end