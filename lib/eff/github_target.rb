class GithubTarget
  attr_reader :username, :repository

  def initialize(username, repository)
    @username = username
    @repository = repository
  end
end
