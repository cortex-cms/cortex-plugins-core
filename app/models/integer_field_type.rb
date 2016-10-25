class IntegerFieldType < FieldType
  attr_accessor :integer

  validates :integer, presence: true, if: :validate_presence?
  validates_numericality_of :integer
  validate :less_than, if: :validate_min?
  validate :greater_than, if: :validate_max?

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
    "#{field_name.parameterize('_')}_integer"
  end

  def less_than
     errors.add(:integer, "must be less_than #{@validations[:max]}") if :integer <= validations[:max]
  end

  def greater_than
     errors.add(:integer, "must be greater_than #{@validations[:min]}") if :integer >= validations[:min]
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