require 'github_api'
require 'digest/md5'

module Eff
  class GithubNotifier
    def initialize(target, oauth_token)
      @target = target
      @api = Github.new(oauth_token: oauth_token).issues
    end

    def deliver(exception, env)
      hash = Digest::MD5.hexdigest([exception.message, exception.backtrace].join('\n'))
      exception_label = "exception-#{hash}"

      if @api.list_repo(@target.username, @target.repository,
                        labels: exception_label, state: 'open').empty?
        @api.create(@target.username, @target.repository, title: exception.message, labels: [exception_label])
      end
    end
  end
end
