require 'spec_helper'
require_relative '../lib/eff/github_notifier'
require_relative '../lib/eff/github_target'

require 'digest/md5'

describe Eff::GithubNotifier do
  let(:exception) { StandardError.new('danger') }
  let(:env) { {} }
  let(:issues_api) { double }
  let(:github_target) { GithubTarget.new 'jroes', 'eff' }
  let(:oauth_token) { 'abcdefdef123' }
  let(:label) do
    hash = Digest::MD5.hexdigest([exception.message, exception.backtrace].join('\n'))
    label = "exception-#{hash}"
  end
  let(:github_instance) { double }

  context "when creating a github issue" do
    before do
      github_instance.should_receive(:issues).and_return(issues_api)
      Github.should_receive(:new).with(oauth_token: oauth_token).and_return(github_instance)
      issues_api.stub(:list_repo).with(github_target.username, github_target.repository,
                                       labels: label, state: 'open').and_return([])
    end

    it "sets title to exception message" do
      issues_api.should_receive(:create).with(github_target.username, github_target.repository,
                                              hash_including(title: exception.message))
      Eff::GithubNotifier.new(github_target, oauth_token).deliver(exception, env)
    end

    it 'adds a hash of exception message and trace as a label' do
      issues_api.should_receive(:create).with(github_target.username, github_target.repository,
                                              hash_including(labels: [label]))
      Eff::GithubNotifier.new(github_target, oauth_token).deliver(exception, env)
    end

    context "and open issue for exception exists" do
      before(:each) do
        issues_api.stub(:list_repo).with(github_target.username, github_target.repository,
                                         labels: label, state: 'open').and_return([double])
      end

      it "doesn't create a new one" do
        issues_api.should_not_receive(:create)
        Eff::GithubNotifier.new(github_target, oauth_token).deliver(exception, env)
      end
    end
  end
end
