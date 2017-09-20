require 'image_processing/mini_magick'
require 'image_optim'

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
    # TODO: support versions without processors
    context[:generated_hex] = SecureRandom.hex(8)
    versions = { original: io.download }

    if image?(io)
      image_optim = image_optim_for(context[:config][:metadata][:image_optim_config])
      versions.merge!(context[:config][:metadata][:versions].transform_values do |version|
        processed_version = send("#{version[:process][:method]}!", io.download, *version[:process][:config].values)
        optimize_image!(processed_version, image_optim) # TODO: per-version image_optim_config
      end)
    end

    versions
  end

  def generate_location(io, context)
    attachment = :assets
    style = context[:version] || :original
    original_name, _dot, original_extension = context[:config][:original_filename].rpartition('.')
    generated_name, _dot, extension = super.rpartition('.')
    generated_hex = context[:generated_hex]

    ERB.new(context[:config][:metadata][:path]).result(binding)
  end

  def image?(io)
    MimeMagic.new(io.data['metadata']['mime_type']).mediatype == 'image'
  end

  private

  def optimize_image!(image, image_optim)
    pathname = image_optim.optimize_image!(image) # TODO: move to ActiveJob
    pathname ? pathname.open : image
  end

  def image_optim_for(image_optim_config)
    ImageOptim.new(process_image_optim_config(image_optim_config))
  end

  def process_image_optim_config(image_optim_config)
    processed_image_optim_config = image_optim_config.merge(pngout: false, svgo: false, verbose: true, skip_missing_workers: false)
    processed_image_optim_config.extend(Hashie::Extensions::DeepLocate)
    quality_range_hashes = processed_image_optim_config.deep_locate -> (key, value, object) { key == :quality_range }
    quality_range_hashes.each do |quality_range_hash|
      quality_range_hash[:quality] = quality_range_hash[:quality_range][:begin]..quality_range_hash[:quality_range][:end]
      quality_range_hash.delete(:quality_range)
    end

    processed_image_optim_config
  end
end
