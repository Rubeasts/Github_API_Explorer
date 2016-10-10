require 'yaml'
require 'http'

# Create the response dumps
github_response = {}
results = {}

# Do not need to initialize - just collecting prelim info
# Add authorization script here for increasing requests limit and more info

# Get ENDPOINT categories
github_api = "https://api.github.com/"

# Choose a username: "rjollet" https://developer.github.com/v3/users/#get-a-single-user

user_endpoint = github_api + "users/"
username = "soumyaray"

# get the user response
user_response = HTTP.get(user_endpoint + username)
user = JSON.load(user_response.to_s)
results[:user] = user

user_repos_response = HTTP.get(user["repos_url"])
user_repos = JSON.load(user_repos_response.to_s)
results[:repos] = user_repos

user_followers_response = HTTP.get(user["followers_url"])
user_followers = JSON.load(user_followers_response.to_s)
results[:followers] = user_followers

user_following_response = HTTP.get(user["followers_url"])
user_following = JSON.load(user_following_response.to_s)
results[:following] = user_following

File.write('results.yml', results.to_yaml)
