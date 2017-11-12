class DateTimeFieldType < FieldType
  attr_accessor :timestamp

  validates :timestamp, presence: true, if: :validate_presence?
  validate :timestamp_is_valid?, if: :validate_presence?

  def elasticsearch_mapping
    { name: mapping_field_name, type: :string, analyzer: :snowball }
  end

  def data=(data_hash)
    @timestamp = data_hash.deep_symbolize_keys[:timestamp]
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = field_item.data['timestamp']
    json
  end

  private

  def mapping_field_name
    "#{field_name.parameterize(separator: '_')}_date_time"
  end

  def timestamp_is_valid?
    begin
      DateTime.parse(@timestamp)
      true
    rescue ArgumentError
      errors.add(:timestamp, 'must be a valid date')
      false
    end
  end

  def validate_presence?
    validations.key? :presence
  end
end
