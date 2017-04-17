require 'shrine'
require 'shrine/storage/file_system'
require 'shrine/storage/s3'

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'),
  store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/store')
}

Shrine.plugin :logging, logger: Rails.logger
Shrine.plugin :cached_attachment_data
