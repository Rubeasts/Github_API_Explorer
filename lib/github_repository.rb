require 'yaml'
require 'http'

# Create the response dumps
# Get ENDPOINT categories

module  Github
  # Main class to set up a Github User
  class Repository
    attr_reader :id, :name, :full_name, :is_private, :is_fork, :created_at,
                :updated_at, :pushed_at, :size, :stargazers_count,
                :watchers_count, :has_issues, :has_downloads, :forks_count,
                :open_issues_count, :forks, :open_issues, :watchers

    def initialize( id, name, full_name, is_private, is_fork, created_at,
                    updated_at, pushed_at, size, stargazers_count,
                    watchers_count, has_issues, has_downloads,
                    forks_count, open_issues_count, forks, open_issues,
                    watchers)
      @id = id,
      @name = name,
      @full_name = full_name,
      @is_private = is_private,
      @is_fork = is_fork,
      @created_at = created_at,
      @updated_at = updated_at,
      @pushed_at = pushed_at,
      @size = size,
      @stargazers_count = stargazers_count,
      @watchers_count = watchers_count,
      @has_issues = has_issues,
      @has_downloads = has_downloads,
      @forks_count = forks_count,
      @open_issues_count = open_issues_count,
      @forks = forks,
      @open_issues = open_issues,
      @watchers = watchers
    end

    def github_api_get(route)
      url = 'https://api.github.com' + route
      github_credential = YAML.load(File.read('config/github_credential.yml'))
      HTTP.basic_auth(:user => github_credential[:username], :pass => github_credential[:token]).get(url)
    end

    def stats
      return @stats if @stats

      @stats = Hash.new
      [ 'contributors',
        'commit_activity',
        'code_frequency',
        'participation',
        'punch_card'].each do |stat|
          repo_stats_response = github_api_get('/' + @full_name + '/stats/' + stat)
          @stats[stat] = JSON.load(repo_stats_response.to_s)
      end
    end

  end
end

# https://developer.github.com/v3/repos/statistics/

# File.write('github_response.yml', github_response.to_yaml)
# File.write('results.yml', results.to_yaml)
