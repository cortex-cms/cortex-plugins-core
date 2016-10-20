class AssetFieldType < FieldType
  attr_accessor :asset_file_name,
                :asset_content_type,
                :asset_file_size,
                :asset_updated_at,
                :asset

  attr_reader :dimensions

  before_save :extract_dimensions

  do_not_validate_attachment_file_type :asset
  validates :asset, attachment_presence: true, if: :validate_presence?
  validate :validate_asset_size, if: :validate_size?
  validate :validate_asset_content_type, if: :validate_content_type?

  def metadata=(metadata_hash)
    @metadata = metadata_hash.deep_symbolize_keys
    Paperclip::HasAttachedFile.define_on(self.class, :asset, metadata)
  end

  def data=(data_hash)
    self.asset = data_hash.deep_symbolize_keys[:asset]
  end

  def data
    {
        'asset': {
            'file_name': asset_file_name,
            'url': asset.url,
            'dimensions': dimensions,
            'content_type': asset_content_type,
            'file_size': asset_file_size,
            'updated_at': asset_updated_at
        }
    }
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

  def image?
    asset_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
  end

  def extract_dimensions
    return unless image?
    tempfile = asset.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      @dimensions = {
          width: geometry.width.to_i,
          height: geometry.height.to_i
      }
    end
  end

  def allowed_content_types
    validations[:allowed_extensions].collect do |allowed_content_type|
      MimeMagic.by_extension(allowed_content_type).type
    end
  end

  def mapping_field_name
    "#{field_name.parameterize('_')}_asset_file_name"
  end

  def validate_presence?
    @validations.key? :presence
  end

  def attachment_size_validator
    AttachmentSizeValidator.new(validations[:size].merge(attributes: :asset))
  end

  def attachment_content_type_validator
    AttachmentContentTypeValidator.new({content_type: allowed_content_types}.merge(attributes: :asset))
  end

  alias_method :valid_presence_validation?, :validate_presence?

  def validate_size?
    begin
      attachment_size_validator
      true
    rescue ArgumentError, NoMethodError
      false
    end
  end

  def validate_content_type?
    begin
      attachment_content_type_validator
      true
    rescue ArgumentError, NoMethodError
      false
    end
  end

  def validate_asset_size
    attachment_size_validator.validate_each(self, :asset, asset)
  end

  def validate_asset_content_type
    attachment_content_type_validator.validate_each(self, :asset, asset)
  end
end
