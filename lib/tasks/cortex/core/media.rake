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
        media.save

        puts "Creating Fields..."

        allowed_asset_content_types = %w(txt pdf doc docx xls xlsx png jpg gif bmp)
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
                                 styles: {
                                     large: {geometry: '1800x1800>', format: :jpg},
                                     medium: {geometry: '800x800>', format: :jpg},
                                     default: {geometry: '300x300>', format: :jpg},
                                     mini: {geometry: '100x100>', format: :jpg},
                                     micro: {geometry: '50x50>', format: :jpg},
                                     post_tile: {geometry: '1140x', format: :jpg}
                                 },
                                 processors: [:thumbnail, :paperclip_optimizer],
                                 preserve_files: true,
                                 path: ':class/:attachment/careerbuilder-:style-:id.:extension',
                                 s3_headers: {'Cache-Control': 'public, max-age=315576000'}
                             })
        media.fields.new(name: 'Title', field_type: 'text_field_type', validations: {presence: true})
        media.fields.new(name: 'Description', field_type: 'text_field_type', validations: {presence: true})
        media.fields.new(name: 'Tags', field_type: 'tag_field_type')
        media.fields.new(name: 'Expiration Date', field_type: 'date_time_field_type')
        media.fields.new(name: 'Alt Tag', field_type: 'text_field_type', order_position: 6)
        media.save

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
                            "fields": [
                                {
                                    "id": media.fields[0].id
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
                            "grid_width": 12,
                            "fields": [
                                {
                                    "id": media.fields[1].id
                                },
                                {
                                    "id": media.fields[2].id
                                },
                                {
                                    "id": media.fields[3].id
                                },
                                {
                                    "id": media.fields[4].id
                                },
                                {
                                    "id": media.fields[5].id
                                }
                            ]
                        }
                    ]
                }
            ]
        }

        media_wizard_decorator = Decorator.new(name: "Wizard", data: wizard_hash)
        media_wizard_decorator.save

        ContentableDecorator.create({
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
                                          "method": "author_image"
                                      },
                                      "display": {
                                          "classes": [
                                              "circular"
                                          ]
                                      }
                                  }]
                    },
                    {
                        "name": "Creator",
                        "cells": [{
                                      "field": {
                                          "method": "author_image"
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
                                    "id": media.fields[1].id
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
                                    "id": media.fields[2].id
                                }
                            }
                        ]
                    },
                    {
                        "name": "Tags",
                        "cells": [
                            {
                                "field": {
                                    "id": media.fields[3].id
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
        media_index_decorator.save

        ContentableDecorator.create({
                                        decorator_id: media_index_decorator.id,
                                        contentable_id: media.id,
                                        contentable_type: 'ContentType'
                                    })
      end
    end
  end
end
