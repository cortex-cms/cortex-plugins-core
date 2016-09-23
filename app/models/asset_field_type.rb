class AssetFieldType < FieldType
  VALIDATION_TYPES = {
    presence: :valid_presence_validation?,
    size: :valid_size_validation?,
    content_type: :valid_content_type_validation?
  }.freeze

  attr_accessor :asset_file_name,
                :asset_content_type,
                :asset_file_size,
                :asset_updated_at,
                :field_name

  attr_reader :data, :validations

  has_attached_file :asset
  do_not_validate_attachment_file_type :asset

  validates :asset, attachment_presence: true, if: :validate_presence?

  def validations=(validations_hash)
    @validations = validations_hash.deep_symbolize_keys
  end

  def data=(data_hash)
    self.asset = data_hash.deep_symbolize_keys[:asset]
  end

  def acceptable_validations?
    valid_types? && valid_options?
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = asset_file_name
    json
  end

  def mapping
    {name: mapping_field_name, type: :string, analyzer: :keyword}
  end

  private

  def mapping_field_name
    "#{field_name.parameterize('_')}_asset_file_name"
  end

  def valid_types?
    validations.all? do |type, options|
      VALIDATION_TYPES.include?(type.to_sym)
    end
  end

  def valid_options?
    validations.all? do |type, options|
      self.send(VALIDATION_TYPES[type])
    end
  end

  def validate_presence?
    @validations.key? :presence
  end

  alias_method :valid_presence_validation?, :validate_presence?

  def valid_size_validation?
    begin
      AttachmentSizeValidator.new(validations[:size].merge(attributes: :asset))
      true
    rescue ArgumentError, NoMethodError
      false
    end
  end

  def valid_content_type_validation?
    begin
      AttachmentContentTypeValidator.new(validations[:content_type].merge(attributes: :asset))
      true
    rescue ArgumentError, NoMethodError
      false
    end
  end
end
