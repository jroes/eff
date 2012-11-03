require 'spec_helper'
require_relative '../lib/eff/exception_handler'

describe Eff::ExceptionHandler do
  let(:app) { double }
  let(:notifier) { double }
  let(:handler) { Eff::ExceptionHandler.new(app, notifier) }

  context 'when an exception is raised' do
    it 'notifies' do
      env = {}
      exception = StandardError.new
      app.stub(:call).and_raise(exception)
      notifier.should_receive(:deliver).with(exception, env)
      handler.call(env)
    end
  end

  context 'when an exception is not raised' do
    it 'does not notify' do
      app.stub(:call)
      notifier.should_not_receive(:deliver)
      handler.call({})
    end
  end
end
