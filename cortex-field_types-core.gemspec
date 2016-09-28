$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cortex/field_types/core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cortex-field_types-core"
  s.version     = Cortex::FieldTypes::Core::VERSION
  s.authors     = ["CareerBuilder Employer Site & Content Products"]
  s.email       = ["EmployerSiteContentProducts@cb.com"]

  s.summary     = %q{The combined set of Core FieldTypes for the Cortex CMS platform}
  s.homepage    = "https://github.com/cortex-cms/cortex-field_types-core"
  s.license     = "Apache-2.0"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE.md", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4"
  s.add_dependency "cells", "~> 4.1"
  s.add_dependency "cells-rails", "~> 0.0.6"
  s.add_dependency "cells-haml", "~> 0.0.10"
  s.add_dependency "ckeditor", "~> 4.2.0"

  s.add_development_dependency "sqlite3"
end
