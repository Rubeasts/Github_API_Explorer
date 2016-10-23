require_relative 'github_api'
require_relative 'github_repository'

module  Github
  # Main class to set up a Github User
  class Developer
    attr_reader :name, :id, :public_repos, :followers, :following

    def initialize(github_api, data:)
      @github_api = github_api
      @name = data['login']
      @id = data['id']
      @public_repos = data['public_repos']
    end

    def repos
      return @repos if @repos

      @repos = @github_api.user_repos(@name).map do |repo_data|
        Github::Repository.new(@github_api, data: repo_data)
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

    def self.find(github_api, username:)
      user_data = github_api.user_info(username)
      new(github_api, data: user_data)
    end
  end
end
