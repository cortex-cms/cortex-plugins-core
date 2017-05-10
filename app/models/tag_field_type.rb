class TagFieldType < FieldType
  attr_accessor :tag_list

  validates :tag_list, presence: true, if: :validate_presence?

  def data=(data_hash)
    @tag_list = data_hash.deep_symbolize_keys[:tag_list]
    @tag_list.nil? ? nil : (@tag_list = @tag_list.split(","))
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = field_item.data['tag_list']
    json
  end

  def mapping
    {name: mapping_field_name, type: :string, analyzer: :snowball}
  end

  private

  def mapping_field_name
    "#{field_name.parameterize(separator: '_')}_tag"
  end

  def validate_presence?
    @validations.key? :presence
  end
end
