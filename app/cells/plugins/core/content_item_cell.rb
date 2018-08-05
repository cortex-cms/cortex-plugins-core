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

      def associated_content_item
        Cortex::ContentItem.find_by_id(value)
      end

      def associated_primary_field
        associated_content_item.content_type.fields.find_by_name(field.metadata['field_name'])
      end

      def associated_primary_field_type_class
        associated_primary_field.field_type_instance.class
      end

      def associated_primary_field_item
        associated_content_item.field_items.find_by_field_id associated_primary_field
      end

      def associated_content_item_title
        # Gross hack, this should rely on 'primary title field' config feature in future, and should use a scope
        title_field_item = associated_content_item.field_items.find do |field_item|
          field_item.field.name == 'Title'
        end

        title_field_item.data['text']
      end

      def render_label
        "Select #{field.name}"
      end

      def render_content_item_id
        @options[:form].hidden_field 'data[content_item_id]', value: value, class: 'association_content_item_id'
      end

      def render_association_cell
        cell(Plugins::Core::AssetCell, associated_primary_field_item,
             associated_content_item: associated_content_item,
             associated_primary_field: associated_primary_field,
             associated_primary_field_type_class: associated_primary_field_type_class,
             associated_primary_field_item: associated_primary_field_item,
             associated_content_item_title: associated_content_item_title)
        .(:association)
      end
    end
  end
end
