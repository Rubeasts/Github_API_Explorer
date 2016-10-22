require './lib/github_developer.rb'
require './lib/github_api'
require './lib/github_repository'

RESULTS = YAML.load(File.read('spec/fixtures/results.yml'))
USERNAME = 'rjollet'.freeze
CREDENTIALS = YAML.load(File.read('config/github_credential.yml'))
