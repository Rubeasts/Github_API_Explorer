require	'minitest/autorun'
require 'minitest/rg'
require 'yaml'

require './lib/github_developer.rb'
require './lib/github_repository.rb'

RESULTS = YAML.load(File.read('spec/fixtures/results.yml'))
USERNAME = "rjollet"
developer = Github::Developer.new(USERNAME)

describe 'Github specifications' do
  it 'should be able to open a new Github Developer' do
    developer.name.length.must_be :>, 0
  end

  it 'should get the user id' do
  	developer.id.must_be :>, 0
  end

  it 'should get the number of public repos' do
  	developer.public_repos.must_be :>, 0
  end

  it 'should get the followers' do
  	developer.followers.length.must_be :>, 0
  end

  it 'should get the following' do
    developer.following.length.must_be :>=, 0
  end

  it 'should get the repos' do
    developer.repos.length.must_be :>, 0
  end
end
