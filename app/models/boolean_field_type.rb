class BooleanFieldType < Cortex::FieldType
  attr_accessor :value

  def elasticsearch_mapping
    { name: mapping_field_name, type: :boolean }
  end

  def data=(data_hash)
    @value = data_hash['value']
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = field_item.data['value']
    json
  end

  private

  def mapping_field_name
    "#{field_name.parameterize(separator: '_')}_boolean"
  end
end
