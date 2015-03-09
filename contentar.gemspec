Gem::Specification.new do |s|
  s.name         = 'contentar'
  s.version      = '0.0.5'
  s.date         = '2015-03-03'
  s.summary      = 'Competitive intelligence'
  s.description  = 'A Gem to produce competitive intelligence data'
  s.executables  = ['contentar']
  s.authors      = ['Vlad Mehakovic']
  s.email        = 'vladiim@yahoo.com.au'
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "readme.md"]#['lib/contentar.rb']
  s.require_path = 'lib'
  s.homepage     = 'https://github.com/vladiim/contentar'
  s.license      = 'MIT'
  s.add_runtime_dependency 'rest-client', '1.7.2'
  s.add_runtime_dependency 'json', '1.8.2'
  s.add_runtime_dependency 'spidr', '0.4.1'
  s.add_runtime_dependency 'dotenv', '1.0.2'
  s.add_development_dependency 'rspec', '3.2.0'
  s.add_development_dependency 'webmock', '1.20.4'
  s.add_development_dependency 'byebug', '3.5.1'
end