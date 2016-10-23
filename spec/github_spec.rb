require_relative 'spec_helper'

describe 'Github specifications' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock

    c.filter_sensitive_data('<AUTH>') { ENV['GH_AUTH'] }
  end

  before do
    VCR.insert_cassette CASSETTE_FILE, record: :new_episodes
    @github_api = Github::API.new(
      ENV['GH_USERNAME'],
      ENV['GH_TOKEN']
    )
    @developer = Github::Developer.new(@github_api, USERNAME)
  end

  after do
    VCR.eject_cassette
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
