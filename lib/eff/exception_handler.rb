module Eff
  class ExceptionHandler
    def initialize(app, notifier)
      @app = app
      @notifier = notifier
    end

    def call(env)
      begin
        @app.call()
      rescue StandardError => e
        @notifier.deliver(e, env)
      end
    end
  end
end
