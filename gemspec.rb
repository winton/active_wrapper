GEM_NAME = 'active_wrapper'
GEM_FILES = FileList['**/*'] - FileList[
  'coverage', 'coverage/**/*',
  'pkg', 'pkg/**/*',
  'spec/example_project/log', 'spec/example_project/log/*'
]
GEM_SPEC = Gem::Specification.new do |s|
  # == CONFIGURE ==
  s.author = "Winton Welsh"
  s.email = "mail@wintoni.us"
  s.homepage = "http://github.com/winton/#{GEM_NAME}"
  s.summary = "Wraps ActiveRecord and Logger for use in non-Rails environments"
  # == CONFIGURE ==
  s.add_dependency('activerecord', '=2.3.5')
  s.add_dependency('actionmailer', '=2.3.5')
  s.extra_rdoc_files = [ "README.markdown" ]
  s.files = GEM_FILES.to_a
  s.has_rdoc = false
  s.name = GEM_NAME
  s.platform = Gem::Platform::RUBY
  s.require_path = "lib"
  s.version = "0.2.6"
end
