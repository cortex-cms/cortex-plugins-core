Bundler.require(:default, Rails.env)

namespace :cortex do
  namespace :core do
    namespace :media do
      desc 'Seed Cortex Media ContentType and Fields'
      task seed: :environment do
        puts "Creating Media ContentType..."
        media = ContentType.new({
                                  name: "Media",
                                  description: "Media for Cortex",
                                  icon: "collections",
                                  creator_id: 1,
                                  contract_id: 1
                                })
        media.save!

        puts "Creating Fields..."

        allowed_asset_content_types = %w(txt css js pdf doc docx ppt pptx csv xls xlsx svg ico png jpg gif bmp)
        fieldTitle = media.fields.new(name: 'Title', field_type: 'text_field_type', validations: {presence: true, uniqueness: true})
        fieldTitle.save
        media.fields.new(name: 'Asset', field_type: 'asset_field_type',
                         validations:
                           {
                             presence: true,
                             allowed_extensions: allowed_asset_content_types,
                             size: {
                               less_than: 50.megabytes
                             }
                           },
                         metadata:
                           {
                             naming_data: {
                               title: fieldTitle.id
                             },
                             versions: {
                               large: {geometry: '1800x1800>', format: :jpg},
                               medium: {geometry: '800x800>', format: :jpg},
                               default: {geometry: '300x300>', format: :jpg},
                               mini: {geometry: '100x100>', format: :jpg},
                               micro: {geometry: '50x50>', format: :jpg},
                               post_tile: {geometry: '1140x', format: :jpg}
                             },
                             keep_files: [:destroyed, :replaced],
                             path: ':class/:attachment/:media_title-:style.:extension',
                             storage: {
                               type: 's3',
                               config: {
                                 access_key_id: ENV['S3_ACCESS_KEY_ID'],
                                 secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
                                 region: ENV['S3_REGION'],
                                 bucket: ENV['S3_BUCKET_NAME'],
                                 upload_options: {cache_control: 'public, max-age=315576000'}
                                 #:url => ':s3_alias_url',
                                 #:s3_host_alias => ENV['S3_HOST_ALIAS'],
                                 #:s3_protocol => ENV['S3_PROTOCOL']
                               }
                             }
                           })
        media.fields.new(name: 'Description', field_type: 'text_field_type', validations: {presence: true})
        media.fields.new(name: 'Tags', field_type: 'tag_field_type')
        media.fields.new(name: 'Expiration Date', field_type: 'date_time_field_type')
        media.fields.new(name: 'Alt Tag', field_type: 'text_field_type')

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
                      "tooltip": "Recommended blog featured image size: 1452px x 530px with a live area of 930px x 530px"
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

        media_wizard_decorator = Decorator.new(name: "Wizard", data: wizard_hash)
        media_wizard_decorator.save!

        ContentableDecorator.create!({
                                      decorator_id: media_wizard_decorator.id,
                                      contentable_id: media.id,
                                      contentable_type: 'ContentType'
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
                              "method": "author_email"
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

        media_index_decorator = Decorator.new(name: "Index", data: index_hash)
        media_index_decorator.save!

        ContentableDecorator.create!({
                                      decorator_id: media_index_decorator.id,
                                      contentable_id: media.id,
                                      contentable_type: 'ContentType'
                                    })
      end
    end
  end
end
