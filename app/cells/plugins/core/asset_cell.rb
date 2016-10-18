module Plugins
  module Core
    class AssetCell < Plugins::Core::Cell
      include UtilityHelper

      def input
        render
      end

      private

      def input_classes
        @options[:input_options]&.[](:display)&.[](:classes)
      end

      def input_styles
        cssify(@options[:input_options]&.[](:display)&.[](:styles))
      end

      def render_label
        @options[:form].label 'data[asset]', field.name
      end

      def render_input
        @options[:form].file_field 'data[asset]'
      end
    end
  end
end
