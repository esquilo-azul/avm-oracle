# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/oracle/version'

Gem::Specification.new do |s|
  s.name        = 'avm-oracle'
  s.version     = Avm::Oracle::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib}/**/*']

  s.add_dependency 'eac_ruby_utils', '~> 0.93'
  s.add_dependency 'ruby-oci8', '~> 2.2', '>= 2.2.11'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5.1'
end
