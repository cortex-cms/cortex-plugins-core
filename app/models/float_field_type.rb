class FloatFieldType < FieldType
  attr_accessor :float
 
  validates_numericality_of :float
  validate :less_than, if: Proc.new { |int| validate_key(:max) }
  validate :greater_than, if: Proc.new { |int| validate_key(:min) }

  def data=(data_hash)
    @float = data_hash.deep_symbolize_keys[:float]
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = field_item.data['float']
    json
  end

  def mapping
    {name: mapping_field_name, type: :float}
  end

  private

  def mapping_field_name
    "#{field_name.parameterize('_')}_float"
  end

  def validate_key(key)
    @validations.key? key
  end

  def less_than
     errors.add(:float, "must be less_than #{@validations[:max]}") if :float <= @validations[:max]
  end

  def greater_than
     errors.add(:float, "must be greater_than #{@validations[:min]}") if :float >= @validations[:min]
  end
end