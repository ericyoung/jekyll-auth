require "bundler/setup"
require 'fileutils'

$:.push File.join(File.dirname(__FILE__), '..', 'lib')

require 'rack/test'
require 'sinatra/auth/github'
require 'sinatra/auth/github/test/test_helper'
require 'webmock/rspec'
require 'dotenv'

def base_dir
  File.expand_path "../", File.dirname(__FILE__)
end

def tmp_dir
  File.expand_path "tmp", base_dir
end

def tear_down_tmp_dir
  FileUtils.rm_rf tmp_dir
end

def setup_tmp_dir
  tear_down_tmp_dir
  FileUtils.mkdir tmp_dir
  File.write File.expand_path("index.html", tmp_dir), "My awesome site"
  FileUtils.mkdir "#{tmp_dir}/some_dir"
  File.write File.expand_path("some_dir/index.html", tmp_dir), "My awesome directory"
  Dir.chdir tmp_dir
end

Dotenv.load
setup_tmp_dir

require_relative "../lib/jekyll-auth"

RSpec.configure do |config|
  config.include(Sinatra::Auth::Github::Test::Helper)
end
