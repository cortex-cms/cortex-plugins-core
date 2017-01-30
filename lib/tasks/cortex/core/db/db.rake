Bundler.require(:default, Rails.env)

namespace :cortex do
  namespace :core do
    namespace :db do
      desc 'Re-Seeds (will wipe existing ContentTypes!) Cortex with Core Custom Content Seed Data'
      task reseed: :environment do
        Rake::Task['cortex:core:db:clear'].execute
        Rake::Task['cortex:core:media:seed'].execute
        Rake::Task['employer:blog:seed'].execute # TODO: Extract
      end

      desc 'Clear Existing Custom Content Data From DB'
      task clear: :environment do
        puts "Clearing ContentTypes..."
        ContentType.destroy_all
        puts "Clearing Fields..."
        Field.destroy_all
        puts "Clearing ContentItems..."
        ContentItem.destroy_all
        puts "Clearing FieldItems..."
        FieldItem.destroy_all
        puts "Clearing ContentableDecorators..."
        ContentableDecorator.destroy_all
        puts "Clearing Decorators..."
        Decorator.destroy_all
      end
    end
  end
end
