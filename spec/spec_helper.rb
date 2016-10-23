require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'vcr'
require 'webmock'

require_relative '../lib/github_developer'
require_relative  '../lib/github_api'
require_relative '../lib/github_repository'

FIXTURES_FOLDER = 'spec/fixtures'
CASSETTES_FOLDER = "#{FIXTURES_FOLDER}/cassettes"
CASSETTE_FILE = 'github_api'

RESULTS = YAML.load(File.read('spec/fixtures/results.yml'))
USERNAME = 'rjollet'.freeze

if File.file?('config/github_credential.yml')
  credentials = YAML.load(File.read('config/github_credential.yml'))
  ENV['GH_USERNAME'] = credentials[:username]
  ENV['GH_TOKEN'] = credentials[:token]
  ENV['GH_AUTH'] = credentials[:auth]
end
