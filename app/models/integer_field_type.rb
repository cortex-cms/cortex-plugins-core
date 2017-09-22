class IntegerFieldType < FieldType
  attr_accessor :integer

  validates :integer, presence: true, if: Proc.new { |int| validate_key(:presence) }
  validates_numericality_of :integer, unless: "integer.nil?"
  validate :less_than, if: Proc.new { |int| validate_key(:max) }
  validate :greater_than, if:  Proc.new { |int| validate_key(:min) }

  def data=(data_hash)
    @integer = data_hash.deep_symbolize_keys[:integer]
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = field_item.data['integer']
    json
  end

  def mapping
    {name: mapping_field_name, type: :integer}
  end

  private

  def mapping_field_name
    "#{field_name.parameterize(separator: '_')}_integer"
  end

  def validate_key
    validations.key? key
  end

  def less_than
     errors.add(:integer, "must be less_than #{validations[:max]}") if :integer <= validations[:max]
  end

  def greater_than
     errors.add(:integer, "must be greater_than #{validations[:min]}") if :integer >= validations[:min]
  end
end
