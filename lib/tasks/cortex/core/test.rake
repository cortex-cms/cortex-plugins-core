Bundler.require(:default, Rails.env)

namespace :cortex do
  namespace :core do
    task test: :environment do
      desc "Prepares and runs the plugin's test suite"

      %x( git submodule add https://github.com/cbdr/cortex.git )
    end
  end
end
