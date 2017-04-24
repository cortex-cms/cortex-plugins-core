class Shrine
  module Plugins
    module CortexValidationHelpers
      module AttacherMethods
        def validations
          context[:validations]
        end

        def validate?(validation)
          validations.key? validation
        end

        def allowed_content_types
          validations[:allowed_extensions].collect do |allowed_content_type|
            MimeMagic.by_extension(allowed_content_type).type
          end
        end
      end
    end

    register_plugin(:cortex_validation_helpers, CortexValidationHelpers)
  end
end
