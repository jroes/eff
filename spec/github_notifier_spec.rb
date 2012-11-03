require 'spec_helper'
require_relative '../lib/eff/github_notifier'
require_relative '../lib/eff/github_target'

describe Eff::GithubNotifier do
  let(:exception) { StandardError.new }
  let(:env) { {} }
  let(:issues_api) { double }
  let(:github_target) { GithubTarget.new 'jroes', 'eff' }
  let(:oauth_token) { 'abcdefdef123' }

  it 'creates a github issue' do
    github_instance = double
    github_instance.should_receive(:issues).and_return(issues_api)
    Github.should_receive(:new).with(oauth_token: oauth_token).and_return(github_instance)
    details = { title: exception.message }
    issues_api.should_receive(:create).with(github_target.username, github_target.repository,
                                            details)
    Eff::GithubNotifier.new(github_target, oauth_token).deliver(exception, env)
  end
end
