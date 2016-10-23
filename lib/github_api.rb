require 'yaml'
require 'http'
require 'json'

# Create the response dumps
# Get ENDPOINT categories

module  Github
  # Main class to set up a Github User
  class API
    GITHUB_API_URL = 'https://api.github.com'.freeze

    def initialize(username, token)
      @username = username
      @token = token
    end

    def github_api_get_http(url)
      HTTP.basic_auth(user: @username, pass: @token).get(url)
    end

    def github_api_wait_cache(url)
      response = github_api_get_http(url)
      while response.headers['Status'].split(' ').first == '202'
        sleep(2)
        response = github_api_get_http(url)
      end
      response
    end

    def github_api_get(route)
      url = GITHUB_API_URL + route
      response = github_api_wait_cache(url)
      JSON.parse(response.to_s)
    end

    def user_info(username)
      route = '/users/' + username
      github_api_get(route)
    end

    def user_followers(username)
      route = '/users/' + username + '/followers'
      github_api_get(route)
    end

    def user_following(username)
      route = '/users/' + username + '/following'
      github_api_get(route)
    end

    def user_repos(username)
      route = '/users/' + username + '/repos'
      github_api_get(route)
    end

    def repo_stat(full_name, stat)
      route = '/repos/' + full_name + '/stats/' + stat
      github_api_get(route)
    end
  end
end
