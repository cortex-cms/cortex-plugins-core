module Plugins
  module Core
    class Cell < FieldCell
      view_paths << "#{Cortex::Plugins::Core::Engine.root}/app/cells"

      def required?
        unless @options[:validations].blank?
          @options[:validations][:presence] == true
        end
      end
    end
  end
end
