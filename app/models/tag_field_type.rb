class TagFieldType < FieldType
  attr_accessor :tag_list

  validates :tag_list, presence: true, if: :validate_presence?

  def elasticsearch_mapping
    { name: mapping_field_name, analyzer: :keyword }
  end

  def data=(data_hash)
    @tag_list = tag_list_to_a data_hash['tag_list']
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = tag_list_to_a field_item.data['tag_list']
    json
  end

  private

  def mapping_field_name
    "#{field_name.parameterize(separator: '_')}_tags"
  end

  def validate_presence?
    validations.key? :presence
  end

  def tag_list_to_a(string)
    string&.split(',')&.map(&:strip)
  end
end
