require 'shrine/storage/s3'

class AssetFieldType < FieldType
  attr_reader :asset,
              :existing_data

  attr_accessor :asset_data

  before_save :promote

  validate :asset_presence, if: :validate_presence?
  validate :asset_errors

  def metadata=(metadata_hash)
    @metadata = metadata_hash.deep_symbolize_keys
    @existing_data = metadata[:existing_data]
  end

  def data=(data_hash)
    attacher.assign data_hash['asset'].open if data_hash['asset']
    @asset = attacher.get
  end

  def data
    return {} if errors.any? || attacher.errors.any?

    {
      asset: {
        original_filename: asset[:original].original_filename,
        # TODO: updated_at: asset.updated_at, -- Does Shrine give this to us? Potentially distinct from record's updated_at
        versions: versions_data
      },
      shrine_asset: asset.to_json
    }
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = field_item.data['asset']['original_filename']
    json
  end

  def mapping
    { name: mapping_field_name, type: :string, analyzer: :keyword }
  end

  private

  def image?
    MimeMagic.new(asset.mime_type).mediatype == 'image'
  end

  def mapping_field_name
    "#{field_name.parameterize('_')}_asset_file_name"
  end

  def promote
    @asset = attacher.promote action: :store unless asset.is_a?(Hash)
  end

  def media_title
    # TODO: Abstract this somehow
    existing_data['media_title'] || ContentItemService.form_fields[metadata[:naming_data][:title]][:text].parameterize.underscore
  end

  def store
    case metadata[:storage][:type]
      when 's3'
        Shrine::Storage::S3.new(metadata[:storage][:config]) # TODO: Encrypt credentials?
      when 'file_system'
        Shrine::Storage::FileSystem.new(metadata[:storage][:config])
      else
        AssetUploader.storages[:store]
    end
  end

  def attacher
    unless @attacher
      AssetUploader.storages[:store_copy] = store # this may not be thread safe, but no other way to do this right now
      AssetUploader.opts[:keep_files] = metadata[:keep_files] # this may not be thread safe, but no other way to do this right now
      @attacher = AssetUploader::Attacher.new self, :asset, store: :store_copy
      @attacher.context[:metadata] = metadata
      @attacher.context[:validations] = validations
    end

    @attacher
  end

  def host_alias
    metadata[:storage][:host_alias] unless metadata[:storage][:host_alias].empty?
  end

  def versions_data
    asset.transform_values do |version|
      {
        id: version.id,
        filename: version.metadata['filename'],
        extension: version.extension,
        mime_type: version.mime_type,
        url: version.url(public: true, host: host_alias),
        file_size: version.size,
        dimensions: {
          width: version.width,
          height: version.height
        }
      }
    end
  end

  def validate_presence?
    validations.key? :presence
  end

  def asset_presence
    errors.add(:asset, 'must be present') unless asset
  end

  def asset_errors
    attacher.errors.each do |message|
      errors.add(:asset, message)
    end
  end
end
