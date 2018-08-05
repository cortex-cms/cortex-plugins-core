module Plugins
  module Core
    class Cell < Cortex::FieldCell
      self.view_paths = ["#{Cortex::Plugins::Core::Engine.root}/app/cells"]

      def required?
        field.validations["presence"]
      end
    end
  end
end
