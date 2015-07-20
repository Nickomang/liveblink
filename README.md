# Liveblink

Liveblink is a CLI (command line interface) that streamlines the process of watching Twitch streams via [livestreamer](http://livestreamer.io). It has some nice features such as an easy-access favorites list, and the ability to watch the streamer's latest VOD. You can view more information as well as versioning history on Liveblink's [rubygems page](https://rubygems.org/gems/liveblink).

## Installation

Make sure you have livestreamer installed. You can find it at [livestreamer.io](http://livestreamer.io)

Open terminal (or your prefered alternative) and type:

    $ gem install liveblink


If you get an error, it's likely a problem with ruby. You can test if your ruby is working by typing:
	
	$ ruby -v

If you get another error, then you'll need to reinstall ruby. There are a lot of guides on the web on how to do this, so some google searching should help you accomplish this. If you get some output detailing a version, then ruby is not the problem. You can google the error or ask me directly (my email is nickomang@gmail.com)

## Usage

The simplest way to use liveblink is just by typing in the name of the streamer you want to watch. For example:

	$ liveblink arteezy

There is an optional parameter following the name for quality, which defaults to best if nothing is provided.

Name | Description
-----|------------
liveblink [STREAM] \(QUALITY) | Watches stream
liveblink fav add [NAME] | Adds [NAME] to favorites list

## Contributing

Bug reports and pull requests are welcome.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

