class ContentItemFieldType < FieldType
  attr_accessor :content_item_id

  def data=(data_hash)
    @content_item_id = data_hash.deep_symbolize_keys[:content_item_id]
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = field_item.data['content_item']
    json
  end

  def mapping
    { name: mapping_field_name, type: :string, analyzer: :snowball }
  end

  private

  def mapping_field_name
    "#{field_name.parameterize('_')}_content_item"
  end
end
