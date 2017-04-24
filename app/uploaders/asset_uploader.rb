require 'image_processing/mini_magick'

class AssetUploader < Shrine
  include ImageProcessing::MiniMagick

  plugin :determine_mime_type
  plugin :store_dimensions
  plugin :validation_helpers
  plugin :cortex_validation_helpers
  plugin :processing
  plugin :versions
  plugin :keep_files, destroyed: true, replaced: true

  Attacher.validate do
    # TODO: DRY this via metaprogramming
    validate_mime_type_inclusion allowed_content_types if validate? :allowed_extensions
    validate_max_size validations[:max_size] if validate? :max_size
    validate_min_size validations[:min_size] if validate? :min_size

    if store.image?(get)
      validate_max_width validations[:max_width] if validate? :max_width
      validate_max_height validations[:max_height] if validate? :max_height
      validate_min_width validations[:min_width] if validate? :min_width
      validate_min_height validations[:min_height] if validate? :min_height
    end
  end

  process(:store) do |io, context|
    # TODO: Perform image optimizations (build plugin), support versions without processors or formatters
    versions = { original: io.download }

    if image?(io)
      versions.merge(context[:metadata][:versions].transform_values do |version|
        processed_version = send("#{version[:process][:method]}!", io.download, *version[:process][:config].values)
        convert!(processed_version, version[:format])
      end)
    end
  end

  def _generate_location(io, context)
    # TODO: This is broken
    attachment = :asset
    media_title = ''
    style = context[:version] || :original
    name = super

    ERB.new(context[:metadata][:path]).result # TODO: Shrine is overwriting metadata..
  end

  def image?(io)
    MimeMagic.new(io.data['metadata']['mime_type']).mediatype == 'image'
  end
end
