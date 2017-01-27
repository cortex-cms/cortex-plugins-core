module Plugins
  module Core
    class Cell < FieldCell
      view_paths << "#{Cortex::Plugins::Core::Engine.root}/app/cells"

      def required?
        field_item.field.validations["presence"] == true
      end
    end
  end
end
