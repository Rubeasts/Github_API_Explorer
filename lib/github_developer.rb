require_relative 'github_api'
require_relative 'github_repository'

module  Github
  # Main class to set up a Github User
  class Developer
    attr_reader :name, :id, :public_repos, :followers, :following

    def initialize(github_api, username)
      @github_api = github_api
      user = @github_api.user_info(username)
      @name = user['login']
      @id = user['id']
      @public_repos = user['public_repos']
    end

    def repos
      return @repos if @repos

      @repos = @github_api.user_repos(@name).map do |repo|
        Github::Repository.new(@github_api, repo)
      end
    end

    def followers
      return @followers if @followers

      @followers = @github_api.user_followers @name
    end

    def following
      return @following if @following

      @following = @github_api.user_following @name
    end
  end
end
