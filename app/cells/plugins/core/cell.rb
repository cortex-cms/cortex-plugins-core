module Plugins
  module Core
    class Cell < FieldCell
      view_paths << "#{Cortex::Plugins::Core::Engine.root}/app/cells"

      def required?
        @options[:presence_validation] == true
      end
    end
  end
end
