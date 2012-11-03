require 'github_api'

module Eff
  class GithubNotifier
    def initialize(target, oauth_token)
      @target = target
      @api = Github.new(oauth_token: oauth_token).issues
    end

    def deliver(exception, env)
      @api.create(@target.username, @target.repository, title: exception.message)
    end
  end
end
