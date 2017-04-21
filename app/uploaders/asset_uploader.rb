require 'image_processing/mini_magick'

class AssetUploader < Shrine
  include ImageProcessing::MiniMagick

  plugin :determine_mime_type
  plugin :store_dimensions
  plugin :validation_helpers
  plugin :pretty_location
  plugin :processing
  plugin :versions
  plugin :keep_files, destroyed: true, replaced: true

  Attacher.validate do
    validate_max_size 5.megabytes, message: 'is too large (max is 5 MB)'
    validate_mime_type_inclusion %w(image/jpeg image/png image/gif)
  end

  process(:store) do |io, context|
    if image?(io)
      thumb = resize_to_limit!(io.download, 200, 200)
      mini = resize_to_limit!(io.download, 100, 100)
      { original: io, thumb: thumb, mini: mini }

      # Perform optimizations
    else
      { original: io }
    end
  end

  private

  def image?(io)
    MimeMagic.new(io.data['metadata']['mime_type']).mediatype == 'image'
  end
end
