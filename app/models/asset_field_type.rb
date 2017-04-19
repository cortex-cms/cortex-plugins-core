class AssetFieldType < FieldType
  attr_reader :asset,
              :existing_data

  attr_accessor :asset_data

  def metadata=(metadata_hash)
    @metadata = metadata_hash.deep_symbolize_keys
    @existing_data = @metadata[:existing_data]
  end

  def data=(data_hash)
    attacher = ImageUploader::Attacher.new self, :asset
    attacher.context[:metadata] = @metadata
    uploader = ImageUploader.new :cache
    asset_file = uploader.upload data_hash['asset']

    attacher.set asset_file
    @asset = attacher.promote action: :store
  end

  def data
    {
      asset: {
        original_filename: asset[:original].original_filename,
        #updated_at: asset.updated_at, # Does Shrine give this to us?
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

  def allowed_content_types
    validations[:allowed_extensions].collect do |allowed_content_type|
      MimeMagic.by_extension(allowed_content_type).type
    end
  end

  def mapping_field_name
    "#{field_name.parameterize('_')}_asset_file_name"
  end

  def versions_data
    asset.transform_values do |version|
      {
        id: version.id,
        filename: version.metadata['filename'],
        extension: version.extension,
        mime_type: version.mime_type,
        url: version.url,
        file_size: version.size,
        dimensions: {
          width: version.width,
          height: version.height
        }
      }
    end
  end
end
