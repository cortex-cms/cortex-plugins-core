$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cortex/plugins/core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cortex-plugins-core"
  s.version     = Cortex::Plugins::Core::VERSION
  s.authors     = ["CareerBuilder Employer Site & Content Products"]
  s.email       = ["EmployerSiteContentProducts@cb.com"]

  s.summary     = %q{The combined set of Core FieldTypes for the Cortex CMS platform}
  s.homepage    = "https://github.com/cortex-cms/cortex-plugins-core"
  s.license     = "Apache-2.0"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE.md", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4"
  s.add_dependency "cells", "~> 4.1"
  s.add_dependency "cells-rails", "~> 0.0.6"
  s.add_dependency "cells-haml", "~> 0.0.10"
  s.add_dependency "mimemagic", "~> 0.3.2"
  s.add_dependency "jsonb_accessor", "~> 1.0.0.beta"
  s.add_dependency "sqlite3", "~> 1.3"
end
