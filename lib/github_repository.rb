require_relative 'github_api'
require_relative 'github_developer'

module  Github
  # Main class to set up a Github User
  class Repository
    attr_reader :id, :name, :full_name, :is_private, :is_fork, :created_at,
                :updated_at, :pushed_at, :size, :stargazers_count,
                :watchers_count, :has_issues, :has_downloads, :forks_count,
                :open_issues_count, :forks, :open_issues, :watchers

    def initialize(github_api, repo)
      @github_api = github_api
      @id = repo['id']
      @name = repo['name']
      @full_name = repo['full_name']
      @is_private = repo['is_private']
      @is_fork = repo['is_fork']
      @created_at = repo['created_at']
      @updated_at = repo['updated_at']
      @pushed_at = repo['pushed_at']
      @size = repo['size']
      @stargazers_count = repo['stargazers_count']
      @watchers_count = repo['watchers_count']
      @has_issues = repo['has_issues']
      @has_downloads = repo['has_downloads']
      @forks_count = repo['forks_count']
      @open_issues_count = repo['open_issues_count']
      @forks = repo['forks']
      @open_issues = repo['open_issues']
      @watchers = repo['watchers']
    end

    def stats
      return @stats if @stats

      @stats = {}
      %w(
        contributors commit_activity code_frequency participation punch_card
      ).each do |stat|
        @stats[stat] = @github_api.repo_stat(@full_name, stat)
      end
    end
  end
end
