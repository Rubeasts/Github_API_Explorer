require 'yaml'
require 'http'

# Create the response dumps
# Get ENDPOINT categories

module  Github
  # Main class to set up a Github User
  class Developer
    attr_reader :name, :id, :public_repos, :followers, :following

    def initialize(username)
      user_route = '/users/' + username
      # Choose a username: "soumyaray" https://developer.github.com/v3/users/#get-a-single-user
      user_response = github_api_get(user_route)
      @user = JSON.load(user_response.to_s)
      @name = @user['login']
      @id = @user['id']
      @public_repos = @user['public_repos']
    end

    def github_api_get(route)
      url = 'https://api.github.com' + route
      github_credential = YAML.load(File.read('config/github_credential.yml'))
      HTTP.basic_auth(:user => github_credential[:username], :pass => github_credential[:token]).get(url)
    end

    def repos
      return @repos if @repos

      route = '/users/' + @name + '/repos'
      user_repos_response = github_api_get(route)
      user_repos = JSON.load(user_repos_response.to_s)
      @repos = user_repos.map do |repo|
        Github::Repository.new(
        repo['id'],
        repo['name'],
        repo['full_name'],
        repo['is_private'],
        repo['is_fork'],
        repo['created_at'],
        repo['updated_at'],
        repo['pushed_at'],
        repo['size'],
        repo['stargazers_count'],
        repo['watchers_count'],
        repo['has_issues'],
        repo['has_downloads'],
        repo['forks_count'],
        repo['open_issues_count'],
        repo['forks'],
        repo['open_issues'],
        repo['watchers'])
      end
    end

    def followers
      return @followers if @followers

      route = '/users/' + @name + '/followers'
      user_followers_response = github_api_get(route)
      @followers = JSON.load(user_followers_response.to_s)

    end

    def following
      return @following if @following

      route = '/users/' + @name + '/following'
      user_following_response = github_api_get(route)
      @following = JSON.load(user_following_response.to_s)
    end
  end
end

# https://developer.github.com/v3/repos/statistics/

# File.write('github_response.yml', github_response.to_yaml)
# File.write('results.yml', results.to_yaml)
