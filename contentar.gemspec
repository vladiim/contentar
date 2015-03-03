Gem::Specification.new do |s|
  s.name         = 'contentar'
  s.version      = '0.0.0'
  s.date         = '2015-03-03'
  s.summary      = 'Blah'
  s.description  = 'A Gem to produce competitive intelligence data'
  s.executables  = ['contentar']
  s.authors      = ['Vlad Mehakovic']
  s.email        = 'vladiim@yahoo.com.au'
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "readme.md"]#['lib/contentar.rb']
  s.require_path = 'lib'
  s.homepage     = 'https://github.com/vladiim/contentar'
  s.license      = 'MIT'
  s.add_development_dependency 'rspec'
end