require 'ckeditor'
require 'jsonb_accessor'

module Cortex
  module Plugins
    module Core
      class Engine < ::Rails::Engine
        initializer 'cortex-plugins-core.assets.precompile' do |app|
          app.config.assets.precompile += %w( ckeditor/* )
        end
      end
    end
  end
end
