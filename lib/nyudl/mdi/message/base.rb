require 'securerandom'
require 'multi_json'
require 'validatable'

module NYUDL
  module MDI
    module Message
      # Abstract Base Message class containing common attributes and methods
      class Base
        include Validatable

        def initialize(incoming = {})
          h[:version]    = incoming[:version]    || MESSAGE_STRUCTURE_VERSION
          h[:request_id] = incoming[:request_id] || SecureRandom.uuid
          h[:params]     = incoming[:params]
        end

        def version
          h[:version]
        end

        def request_id
          h[:request_id]
        end

        def params
          h[:params]
        end

        def params=(arg)
          h[:params] = arg
        end

        def to_json
          MultiJson.dump(h)
        end

        private

        def h
          @h ||= {}
        end
      end
    end
  end
end
