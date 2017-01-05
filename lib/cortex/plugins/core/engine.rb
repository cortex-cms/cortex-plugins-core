require 'jsonb_accessor'

module Cortex
  module Plugins
    module Core
      class Engine < ::Rails::Engine
        initializer 'cortex-plugins-core.assets.precompile' do |app|
          app.config.assets.precompile += %w(ckeditor/config.js)
        end
      end
    end
  end
end
