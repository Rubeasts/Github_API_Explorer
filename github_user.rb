require 'yaml'
require 'http'

# Create the response dumps
github_response = {}
results = {}

# Do not need to initialize - just collecting prelim info
# Add authorization script here for increasing requests limit and more info

def github_api_get(url)
  github_credential = YAML.load(File.read('config/github_credential.yml'))
  HTTP.basic_auth(:user => github_credential[:username], :pass => github_credential[:token]).get(url)
end

# Get ENDPOINT categories
github_api = "https://api.github.com/"

# Choose a username: "soumyaray" https://developer.github.com/v3/users/#get-a-single-user

user_endpoint = github_api + "users/"
username = "soumyaray"

# get the user response
user_response = github_api_get(user_endpoint + username)
github_response[:user] = user_response
user = JSON.load(user_response.to_s)
results[:user] = user

user_repos_response = github_api_get(user["repos_url"])
github_response[:repos] = user_repos_response
user_repos = JSON.load(user_repos_response.to_s)

## WE do not have access to collaborators
#user_repos = user_repos.map do |repo|
#  puts repo["collaborators_url"].partition('{').first
#  repo_collaborators_response = github_api_get(repo["collaborators_url"].partition('{').first)
#  repo["collaborators"] = JSON.load(repo_collaborators_response.to_s)
#  repo
#end

# https://developer.github.com/v3/repos/statistics/
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

results[:repos] = user_repos

user_followers_response = github_api_get(user["followers_url"])
github_response[:followers] = user_followers_response
user_followers = JSON.load(user_followers_response.to_s)
results[:followers] = user_followers

user_following_response = github_api_get(user["following_url"])
github_response[:following] = user_following_response
user_following = JSON.load(user_following_response.to_s)
results[:following] = user_following

File.write('github_response.yml', github_response.to_yaml)
File.write('results.yml', results.to_yaml)
