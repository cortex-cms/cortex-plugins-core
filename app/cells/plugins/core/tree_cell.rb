module Plugins
  module Core
    class TreeCell < Plugins::Core::Cell
      def checkboxes
        render
      end

      def dropdown
        render
      end

      private

      def value
        data&.[]('values') || @options[:default_value]
      end

      def render_select
        @options[:form].select 'data[values]', metadata_values, {selected: value}
      end

      def metadata_values
        @options[:metadata]["data"]["tree_array"].map do |value|
          [display_label(value["node"]["name"]), value["id"]]
        end
      end

      def display_label(label)
        label.blank? ? "N/A" : label
      end
    end
  end
end
