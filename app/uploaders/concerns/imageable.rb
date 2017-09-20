module Imageable
  extend ActiveSupport::Concern

  included do
    def image?(io)
      MimeMagic.new(io.data['metadata']['mime_type']).mediatype == 'image'
    end

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
end
