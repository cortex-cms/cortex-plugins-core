module Plugins
  module Core
    class ContentItemCell < Plugins::Core::Cell
      def popup
        render
      end

      private

      def value
        data&.[]('content_item_id')
      end

      def render_label
        "Add #{field.name}"
      end

      def render_content_item_id
        @options[:form].hidden_field 'data[content_item_id]', value: value
      end
    end
  end
end
