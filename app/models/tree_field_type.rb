class TreeFieldType < FieldType
  attr_accessor :values

  validates :values, presence: true, if: :validate_presence?
  validate  :minimum, if: :validate_minimum?
  validate  :maximum, if: :validate_maximum?

  def data=(data_hash)
    values = data_hash.deep_symbolize_keys[:values]

    if values.is_a?(Hash)
      @values = values.keys
    else
      @values = values
    end
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = field_item.data['tree']
    json
  end

  def mapping
    { name: mapping_field_name, type: :string, analyzer: :snowball }
  end

  private

  def mapping_field_name
    "#{field_name.parameterize('_')}_tree"
  end

  def minimum
    unless @values.nil?
      if @values.length >= @validations[:minimum]
        true
      else
        errors.add(:minimum, "You have selected too few values.")
        false
      end
    end
  end

  def maximum
    unless @values.nil?
      if @values.length <= @validations[:maximum]
        true
      else
        errors.add(:maximum, "You have selected too many values.")
        false
      end
    end
  end

  def validate_presence?
    @validations.key? :presence
  end

  def validate_minimum?
    @validations.key? :minimum
  end

  def validate_maximum?
    @validations.key? :maximum
  end
end
