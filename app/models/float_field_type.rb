class FloatFieldType < FieldType
  attr_accessor :float

  validates :float, presence: true, if: Proc.new { |float| validate_key(:presence) }
  validates_numericality_of :float, unless: "float.nil?"
  validate :less_than, if: Proc.new { |float| validate_key(:max) }
  validate :greater_than, if: Proc.new { |float| validate_key(:min) }

  def elasticsearch_mapping
    { name: mapping_field_name, type: :float }
  end

  def data=(data_hash)
    @float = data_hash['float']
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = field_item.data['float']
    json
  end

  private

  def mapping_field_name
    "#{field_name.parameterize(separator: '_')}_float"
  end

  def validate_key(key)
    validations.key? key
  end

  def less_than
    errors.add(:float, "must be less_than #{validations[:max]}") if :float <= validations[:max]
  end

  def greater_than
    errors.add(:float, "must be greater_than #{validations[:min]}") if :float >= validations[:min]
  end
end
