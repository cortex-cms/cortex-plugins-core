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

      def render_popup
        @options[:form].text_field 'data[content_item_id]', value: value, style: 'display:none;'
      end
    end
  end
end
