class AuthorFieldType < FieldType
  attr_accessor :author_name
  jsonb_accessor :data, author_name: :string

  validates :author_name, presence: true, if: :validate_presence?

  def elasticsearch_mapping
    { name: mapping_field_name, type: :string, analyzer: :keyword }
  end

  def data=(data_hash)
    data_hash[:author_name] = data_hash[:default_author_name] if data_hash['author_name'].blank?
    @author_name = data_hash['author_name']
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = field_item.data['author_name']
    json
  end

  private

  def mapping_field_name
    "#{field_name.parameterize(separator: '_')}_author"
  end

  def author_name_present
    errors.add(:author_name, 'must be present') if @author_name.empty?
  end

  def validate_presence?
    validations.key? :presence
  end
end
