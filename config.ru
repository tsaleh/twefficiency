$LOAD_PATH << File.join(File.dirname(__FILE__), "lib")

root_dir = Pathname(__FILE__).dirname
env = ENV['RACK_ENV'].to_sym

FileUtils.mkdir_p(File.join(root_dir, "log"))  unless File.exists?('log')
log = File.new(File.join(root_dir, "log", "sinatra.log"), "a")
$stdout.reopen(log)
$stderr.reopen(log)

require 'rubygems'
require 'sinatra'
require 'twefficiency'

set :environment, env
set :root,        root_dir
set :app_file,    File.join(root_dir, "lib", 'twefficiency.rb')
disable :run

run Twefficiency
