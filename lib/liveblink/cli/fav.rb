require 'cathodic'

module LiveBlink
	module CLI
		class Fav < Thor
			#favorites
			desc "list", "Displays favorites list"
			method_option :online, :aliases => "-o", :desc => "Lists only streams that are online"
			def list
				online = options[:online]
				if online
					Helper.get_online_favs
				else 
					puts File.read('./lib/favorites.txt')
				end
			end
			default_task :list

			#favorites add NAME
			desc "fav add NAME", "Adds NAME to favorites list"
			def add(name)
				open('./lib/favorites.txt', 'a') { |f|
		  			f.puts name
				}
		 	end

		 	#favorites delete NAME
		 	desc "fav delete NAME", "Deletes NAME from favorites list"
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
				File.foreach('./lib/favorites.txt') {
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