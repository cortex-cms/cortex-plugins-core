Bundler.require(:default, Rails.env)

namespace :cortex do
  namespace :core do
    namespace :media do
      desc 'Seed Cortex Media ContentType and Fields'
      task seed: :environment do
        example_tenant = Cortex::Tenant.find_by_name('Example')

        puts "Creating Media ContentType..."
        media = Cortex::ContentType.new({
                                  name: "Media",
                                  name_id: "media",
                                  description: "Media for Cortex",
                                  icon: "collections",
                                  tenant: example_tenant,
                                  creator: Cortex::User.first,
                                  contract: Cortex::Contract.first # TODO: This is obviously bad. This whole file is bad.
                                })
        media.save!

        puts "Creating Fields..."

        allowed_asset_content_types = %w(txt css js pdf doc docx ppt pptx csv xls xlsx svg ico png jpg gif bmp)
        fieldTitle = media.fields.new(name: 'Title', name_id: 'title', field_type: 'text_field_type', validations: { presence: true, uniqueness: true })
        fieldTitle.save
        media.fields.new(name: 'Asset', name_id: 'asset', field_type: 'asset_field_type',
                         validations:
                           {
                             presence: true,
                             allowed_extensions: allowed_asset_content_types,
                             max_size: 50.megabytes
                           },
                         metadata:
                           {
                             naming_data: {
                               title: fieldTitle.id
                             },
                             versions: { # Move to YAML
                               large: { process: { method: 'resize_to_limit', config: { width: '1800', height: '1800' } } },
                               medium: { process: { method: 'resize_to_limit', config: { width: '800', height: '800' } } },
                               default: { process: { method: 'resize_to_limit', config: { width: '300', height: '300' } } },
                               mini: { process: { method: 'resize_to_limit', config: { width: '100', height: '100' } } },
                               micro: { process: { method: 'resize_to_limit', config: { width: '50', height: '50' } } },
                               rss: { process: { method: 'resize_to_limit', config: { width: '840', height: '840' } } },
                             },
                             keep_files: [:destroyed, :replaced],
                             path: 'media/<%= attachment %>/<%= original_name %>-<%= style %>-<%= generated_hex %>.<%= extension %>',
                             storage: { # Move to YAML
                               type: 's3',
                               host_alias: ENV['HOST_ALIAS'],
                               config: {
                                 access_key_id: ENV['S3_ACCESS_KEY_ID'],
                                 secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
                                 region: ENV['S3_REGION'],
                                 bucket: ENV['S3_BUCKET_NAME'],
                                 upload_options: {
                                   acl: 'public-read',
                                   cache_control: 'public, max-age=315576000'
                                 }
                               }
                             },
                             image_optim_config: {  # Move to YAML
                               allow_lossy: true,
                               jpegoptim: {
                                 allow_lossy: true,
                                 strip: 'all',
                                 max_quality: 60
                               },
                               pngquant: {
                                 allow_lossy: true,
                                 quality_range: {
                                   begin: 33,
                                   end: 50
                                 },
                                 speed: 3
                               },
                               gifsicle: {
                                 interlace: true
                               },
                               advpng: false,
                               jhead: false,
                               jpegrecompress: false,
                               jpegtran: false,
                               optipng: false,
                               pngcrush: false,
                               pngout: false,
                               svgo: false
                             }
                           })
        media.fields.new(name: 'Description', name_id: 'description', field_type: 'text_field_type', validations: {presence: true})
        media.fields.new(name: 'Tags', name_id: 'tags', field_type: 'tag_field_type')
        media.fields.new(name: 'Expiration Date', name_id: 'expiration_date', field_type: 'date_time_field_type')
        media.fields.new(name: 'Alt Tag', name_id: 'alt_tag', field_type: 'text_field_type')

        media.save!

        puts "Creating Wizard Decorators..."
        wizard_hash = {
          "steps": [
            {
              "name": "Upload",
              "heading": "First thing's first..",
              "description": "Add your media asset.",
              "columns": [
                {
                  "grid_width": 12,
                  "elements": [
                    {
                      "id": media.fields.find_by_name('Asset').id,
                      "tooltip": "Recommended Size: 840 x 400 if you want to use a single image as your tile and blog header image."
                    }
                  ]
                }
              ]
            },
            {
              "name": "Metadata",
              "heading": "Let's talk about your asset..",
              "description": "Provide details and metadata that will enhance search or inform end-users.",
              "columns": [
                {
                  "grid_width": 6,
                  "elements": [
                    {
                      "id": media.fields.find_by_name('Title').id
                    },
                    {
                      "id": media.fields.find_by_name('Description').id,
                      "render_method": "multiline_input",
                      "display": {
                         "rows": 3
                      }
                    },
                    {
                      "id": media.fields.find_by_name('Tags').id
                    },
                    {
                      "id": media.fields.find_by_name('Expiration Date').id
                    },
                    {
                      "id": media.fields.find_by_name('Alt Tag').id
                    }
                  ]
                },
                {
                  "grid_width": 6,
                  "elements": [
                    {
                      "plugin": {
                        "class_name": "plugins/core/asset_info",
                        "render_method": "show",
                        "data": {
                          "field_id": media.fields.find_by_name('Asset').id
                        }
                      }
                    },
                  ]
                }
              ]
            }
          ]
        }

        media_wizard_decorator = Cortex::Decorator.new(name: "Wizard", data: wizard_hash, tenant: example_tenant)
        media_wizard_decorator.save!

        Cortex::ContentableDecorator.create!({
                                      decorator_id: media_wizard_decorator.id,
                                      contentable_id: media.id,
                                      contentable_type: 'Cortex::ContentType',
                                      tenant: example_tenant
                                    })

        puts "Creating Index Decorators..."
        index_hash = {
          "columns":
            [
              {
                "name": "Thumbnail",
                "cells": [{
                            "field": {
                              "plugin": {
                                "class_name": "plugins/core/asset_info",
                                "render_method": "index",
                                "data": {
                                  "field_id": media.fields.find_by_name('Asset').id
                                },
                                "config": {
                                  "thumbnail_style": "mini"
                                }
                              }
                            }
                          }]
              },
              {
                "name": "Creator",
                "cells": [{
                            "field": {
                              "method": "creator.email"
                            },
                            "display": {
                              "classes": [
                                "circular"
                              ]
                            }
                          }]
              },
              {
                "name": "Details",
                "cells": [
                  {
                    "field": {
                      "id": media.fields.find_by_name('Title').id
                    },
                    "display": {
                      "classes": [
                        "bold",
                        "upcase"
                      ]
                    }
                  },
                  {
                    "field": {
                      "id": media.fields.find_by_name('Description').id
                    }
                  }
                ]
              },
              {
                "name": "Tags",
                "cells": [
                  {
                    "field": {
                      "id": media.fields.find_by_name('Tags').id
                    },
                    "display": {
                      "classes": [
                        "tag",
                        "rounded"
                      ]
                    }
                  }
                ]
              }
            ]
        }

        media_index_decorator = Cortex::Decorator.new(name: "Index", data: index_hash, tenant: example_tenant)
        media_index_decorator.save!

        Cortex::ContentableDecorator.create!({
                                      decorator_id: media_index_decorator.id,
                                      contentable_id: media.id,
                                      contentable_type: 'Cortex::ContentType',
                                      tenant: example_tenant
                                    })
      end
    end
  end
end
