class TextFieldType < FieldType
  attr_accessor :text
  jsonb_accessor :data, text: :string

  validates :text, presence: true, if: :validate_presence?
  validate :text_length, if: :validate_length?
  validate :text_unique, if: :validate_uniqueness?

  def data=(data_hash)
    @text = data_hash.deep_symbolize_keys[:text]
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = field_item.data['text']
    json
  end

  def mapping
    {name: mapping_field_name, type: :string, analyzer: :snowball}
  end

  private

  def mapping_field_name
    "#{field_name.parameterize('_')}_text"
  end

  def text_length
    validator = LengthValidator.new(validations[:length].merge(attributes: [:text]))
    validator.validate_each(self, :text, text)
  end

  def text_unique
    unless metadata[:existing_data][:text] == text || field.field_items.select { |field_item| field_item.id != metadata[:field_item].id }.jsonb_contains(:data, text: text).empty?
      errors.add(:text, "Must be unique")
    end
  end

  def validate_uniqueness?
    @validations.key? :uniqueness
  end

  def validate_presence?
    @validations.key? :presence
  end

  def validate_length?
    @validations.key? :length
  end
end
