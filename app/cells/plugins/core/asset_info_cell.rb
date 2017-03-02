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

      def asset_thumb(asset)
        asset['style_urls'] ? asset['style_urls'][config[:thumbnail_style]] : 'https://secure.gravatar.com/avatar/f995c9cc06a8282138cf6c0691396f6d'
      end

      def asset
        data['asset']
      end

      def dimensions
        "#{asset['dimensions']['width']} x #{asset['dimensions']['width']}"
      end

      def creator
        content_item.creator
      end

      def created_at
        content_item.created_at.to_formatted_s(:long_ordinal)
      end

      def updated_at
        DateTime.parse(asset['updated_at']).to_formatted_s(:long_ordinal)
      end

      def link_to_asset
        link_to asset['url'], asset['url'], target: '_blank'
      end
    end
  end
end
