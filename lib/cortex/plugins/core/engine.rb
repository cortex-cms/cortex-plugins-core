require 'jsonb_accessor'
require 'react_on_rails'

module Cortex
  module Plugins
    module Core
      class Engine < ::Rails::Engine
        isolate_namespace Cortex::Plugins::Core

        initializer "cortex-plugins-core.precompile_manifest" do |app|
          app.config.assets.precompile += %w(cortex_plugins_core_manifest)
        end
      end
    end
  end
end
