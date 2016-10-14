require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'

require './lib/github_developer.rb'
require './lib/github_api'
require './lib/github_repository'

RESULTS = YAML.load(File.read('spec/fixtures/results.yml'))
USERNAME = 'rjollet'.freeze
CREDENTIALS = YAML.load(File.read('config/github_credential.yml'))

describe 'Github specifications' do
  before do
    @github_api = Github::API.new(
      CREDENTIALS[:username],
      CREDENTIALS[:token]
    )
    @developer = Github::Developer.new(@github_api, USERNAME)
  end

  it 'should be able to open a new Github Developer' do
    @developer.name.length.must_be :>, 0
  end

  it 'should get the user id' do
    @developer.id.must_be :>, 0
  end

  it 'should get the number of public repos' do
    @developer.public_repos.must_be :>, 0
  end

  it 'should get the followers' do
    @developer.followers.length.must_be :>, 0
  end

  it 'should get the following' do
    @developer.following.length.must_be :>=, 0
  end

  it 'should get the repos' do
    @developer.repos.length.must_be :>, 0
  end

  it 'should get the repo should have a full name' do
    @developer.repos.first.full_name.must_be_instance_of String
  end

  it 'should get the repo should have stats' do
    @developer.repos.first.stats.wont_be_nil
  end
end
