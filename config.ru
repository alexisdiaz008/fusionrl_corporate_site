require 'rubygems'
require './corporate_site.rb'

require 'sinatra'
require 'logger'

use Rack::ShowExceptions

run Sinatra::Application

configure :production do
	set :haml, { :ugly=>true }
	set :clean_trace, true

	Dir.mkdir('logs') unless File.exist?('logs')

	$logger = Logger.new('logs/common.log','weekly')
	$logger.level = Logger::WARN

	# Spit stdout and stderr to a file during production
	# in case something goes wrong
	$stdout.reopen("logs/output.log", "w")
	$stdout.sync = true
	$stderr.reopen($stdout)
end

configure :development do
	$logger = Logger.new(STDOUT)
end