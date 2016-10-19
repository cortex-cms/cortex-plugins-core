module Plugins
  module Core
    class Cell < FieldCell
      view_paths << "#{Cortex::Plugins::Core::Engine.root}/app/cells"
    end
  end
end
