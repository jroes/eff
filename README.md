# What is eff?

The expletive you use when your code throws errors in
production. Also, a gem that automatically creates GitHub issues when
your app throws errors.

# Installation

1. Add the following to your Gemfile:

```ruby
gem 'eff'
```

2. Add this to `config/environments/production.rb`:

```ruby
  config.middleware.use Eff::ExceptionHandler,
    Eff::GithubNotifier.new(
      GithubTarget.new(ENV['GITHUB_USERNAME'], ENV['GITHUB_REPOSITORY']),
        ENV['GITHUB_OAUTH_TOKEN'])
```

3. Profit!
