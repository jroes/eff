Gem::Specification.new do |s|
  s.name        = 'eff'
  s.version     = '0.0.1'
  s.date        = '2012-11-03'
  s.summary     = "Create GitHub issues when errors happen in your app."
  s.authors     = ["Jon Roes"]
  s.email       = 'jroes@jroes.net'
  s.files       = Dir['lib/**/*.rb']
  s.files       = ["lib/eff.rb", "lib/eff/exception_handler.rb", "lib/eff/github_notifier.rb"]
  s.homepage    = 'http://rubygems.org/gems/eff'
  s.test_files  = Dir.glob('spec/*_spec.rb')

  s.add_dependency("github_api", "~> 0.7.2")
  s.add_development_dependency "rspec", "~> 2.11.0"
end
