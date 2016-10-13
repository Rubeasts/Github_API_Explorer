require 'yaml'
require 'http'

# Create the response dumps
# Get ENDPOINT categories

module  Github
  # Main class to set up a Github User
  class Dev
    attr_reader :name, :id, :public_repos, :followers, :following

    def initialize(username)
      github_api = 'https://api.github.com/'
      user_endpoint = github_api + 'users/'
      # Choose a username: "soumyaray" https://developer.github.com/v3/users/#get-a-single-user
      user_response = github_api_get(user_endpoint + username)
      @user = JSON.load(user_response.to_s)
      @repos = dev_repos_get(username)
      @name = @user['login']
      @id = @user['id']
      @public_repos = @user['public_repos']
      @followers = dev_followers_get(username)
      @following = dev_following_get(username)
    end

    def github_api_get(url)
      github_credential = YAML.load(File.read('config/github_credential.yml'))
      HTTP.basic_auth(:user => github_credential[:username], :pass => github_credential[:token]).get(url)
    end

    def dev_repos_get(user)
      user_repos_response = github_api_get(@user["repos_url"])
      user_repos = JSON.load(user_repos_response.to_s)
      user_repos = user_repos.map do |repo|
        repo["stats"] = [ 'contributors',
                          'commit_activity',
                          'code_frequency',
                          'participation',
                          'punch_card'].map do |stat|
          repo_stats_response = github_api_get(repo["url"] + '/stats/' + stat)
          { stat => JSON.load(repo_stats_response.to_s) }
        end
        repo
      end
      user_repos
    end

    def dev_followers_get(username)
      user_followers_response = github_api_get(@user["followers_url"])
      user_followers = JSON.load(user_followers_response.to_s)
      user_followers
    end

    def dev_following_get(username)
      user_following_response = github_api_get(@user["following_url"])
      user_following = JSON.load(user_following_response.to_s)
      user_following
    end
  end
end

## WE do not have access to collaborators
#user_repos = user_repos.map do |repo|
#  puts repo["collaborators_url"].partition('{').first
#  repo_collaborators_response = github_api_get(repo["collaborators_url"].partition('{').first)
#  repo["collaborators"] = JSON.load(repo_collaborators_response.to_s)
#  repo
#end

# https://developer.github.com/v3/repos/statistics/

# File.write('github_response.yml', github_response.to_yaml)
# File.write('results.yml', results.to_yaml)
