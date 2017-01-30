Bundler.require(:default, Rails.env)

namespace :cortex do
  namespace :core do
    task test: :environment do
      desc "Prepares and runs the plugin's test suite"

      puts "Clearing Cortex Directory"
      %x( git rm -rf cortex && rm -rf ./cortex )
      
      puts "Adding Cortex Submodule"
      %x( git submodule add -f https://github.com/cbdr/cortex.git )
    end
  end
end
