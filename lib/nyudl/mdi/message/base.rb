require 'securerandom'
require 'multi_json'

module NYUDL::MDI::Message
  class Base
    def initialize(params = {})
      h[:version]    = MESSAGE_STRUCTURE_VERSION
      h[:request_id] = SecureRandom.uuid
      h[:params]     = params
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
    def to_json
      MultiJson.dump(h)
    end
    private
    def h
      @h ||= {}
    end
  end
end
