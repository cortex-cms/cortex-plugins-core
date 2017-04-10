module Plugins
  module Core
    class AssetCell < Plugins::Core::Cell
      include ActionView::Helpers::NumberHelper
      include UtilityHelper
      include Cells::AssociationHelper

      def input
        render
      end

      def association
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

      def render_tooltip
        @options[:tooltip]
      end

      def associated_content_item_thumb_url
        data['asset']['style_urls']['mini']
      end

      def render_associated_content_item_thumb
        image_tag(associated_content_item_thumb_url, height: '50px')
      end
    end
  end
end
