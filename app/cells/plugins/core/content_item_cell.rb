module Plugins
  module Core
    class ContentItemCell < Plugins::Core::Cell
      def popup
        render
      end

      private

      def render_label
        "Add #{field.name}"
      end
    end
  end
end
