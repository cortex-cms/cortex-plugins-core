module Plugins
  module Core
    class AssetInfoCell < Plugins::Core::Cell
      include ActionView::Helpers::NumberHelper

      property :data
      property :content_item

      def show
        render
      end

      def index
        render
      end

      private

      def config
        @options[:config] || {}
      end

      def asset
        data['asset']
      end

      def dimensions
        "#{asset['versions']['original']['dimensions']['width']} x #{asset['versions']['original']['dimensions']['width']}"
      end

      def creator
        content_item.creator
      end

      def created_at
        content_item.created_at.to_formatted_s(:long_ordinal)
      end

      def updated_at
        content_item.updated_at.to_formatted_s(:long_ordinal)
      end

      def link_to_asset
        link_to asset['versions']['original']['url'], asset['versions']['original']['url'], target: '_blank'
      end

      def asset_type
        MimeMagic.new(asset['versions']['original']['mime_type']).mediatype
      end

      def asset_is_image?
        asset_type == 'image'
      end
    end
  end
end
