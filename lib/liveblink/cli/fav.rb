require 'cathodic'

module LiveBlink
	module CLI
		# @@fav_path = "./lib/liveblink/cli/favorites.json"
		class Fav < Thor

			@@fav_path = "./lib/liveblink/cli/favorites.json"

			desc "init", "Initializes a favorites list, stored as json."
			def init
				if !(File.file?(@@fav_path))
					puts "making new file"
				else
					puts "file already exists"
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
		 	end

		 	#favorites delete NAME
		 	desc "fav delete [NAME]", "Deletes [NAME] from favorites list"
		 	def delete(name)
		 	end

		 # 	#favorites -o
		 # 	desc "fav -o", "Lists favorite streams that are online"
			# def online
			# 	i = 0
			# 	datas = []
			# 	puts "These streams are online:"
			# 	datas = Helper.get_datas(Helper.get_favs)
			# 	datas.each do |data|
			# 		if data.online == true
			# 			puts data.stream_name + ', playing ' + data.game + ' (' + data.viewers.to_s + ' viewers)'
			# 		end
			# 	end
			# end
		end

		module Helper
			@@fav_path = "./lib/liveblink/cli/favorites.json"

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