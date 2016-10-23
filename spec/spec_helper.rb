require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'

require_relative '../lib/github_developer'
require_relative  '../lib/github_api'
require_relative '../lib/github_repository'

RESULTS = YAML.load(File.read('spec/fixtures/results.yml'))
USERNAME = 'rjollet'.freeze
CREDENTIALS = YAML.load(File.read('config/github_credential.yml'))
