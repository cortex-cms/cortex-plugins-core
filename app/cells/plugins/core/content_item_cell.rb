module Plugins
  module Core
    class ContentItemCell < Plugins::Core::Cell
      def popup
        render
      end

      private

      def render_field_name
        "Insert #{field.name}"
      end
    end
  end
end
