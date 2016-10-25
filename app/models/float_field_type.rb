class FloatFieldType < FieldType

  attr_accessor :float
 
  validates_numericality_of :float
  validate :less_than, if: :validate_min?
  validate :greater_than, if: :validate_max?

  def validations=(validations_hash ={})
    @validations = validations_hash.deep_symbolize_keys
  end

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

  def less_than
     errors.add(:float, "must be less_than #{@validations[:max]}") if @float <= @validations[:max]
  end

  def greater_than
     errors.add(:float, "must be greater_than #{@validations[:min]}") if @float >= @validations[:min]
  end

  def validate_max?
    @validations.key? :max
  end

  def validate_min?
    @validations.key? :min
  end
  
  def valid_presence_validation?
    @validations.key? :presence
  end
 
end