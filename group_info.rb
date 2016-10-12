require 'yaml'
require 'http'

# Create the response dumps
github_response = {}
results = {}

# Do not need to initialize - just collecting prelim info
# Add authorization script here for increasing requests limit and more info

# Get ENDPOINT categories
endpoint_categories = HTTP.get("https://api.github.com")
endpoint = JSON.load(endpoint_categories.to_s)
results[:endpoint] = endpoint

# Choose an organization: "ISS-Analytics"
# Choose a repo: "pls-predict"
# get the organization response
organization_response = HTTP.get("https://api.github.com/orgs/ISS-Analytics")
organization = JSON.load(organization_response.to_s)
results[:organization] = organization

# Get the Repo response
repo_response = HTTP.get("https://api.github.com/repos/ISS-Analytics/pls-predict")
repo = JSON.load(repo_response.to_s)
results[:repo] = repo

# Get the repo issues
repo_issues = HTTP.get("https://api.github.com/repos/ISS-Leimen/pls-predict/issues")
issues = JSON.load(repo_issues.to_s)
results[:issues] = issues

# Get repo collaborators
repo_collab = HTTP.get("https://api.github.com/repos/ISS-Analytics/pls-predict/collaborators")
collab = JSON.load(repo_collab.to_s)
results[:collab] = collab

File.write('results.yml', results.to_yaml)
