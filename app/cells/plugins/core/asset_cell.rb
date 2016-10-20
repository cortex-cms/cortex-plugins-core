module Plugins
  module Core
    class AssetCell < Plugins::Core::Cell
      include ActionView::Helpers::NumberHelper
      include UtilityHelper

      def input
        render
      end

      private

      def render_allowed_asset_extensions
        field.validations['allowed_extensions']&.join(', ')
      end

      def render_max_asset_size
        number_to_human_size(field.validations['size']&.[]('less_than'))
      end

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
