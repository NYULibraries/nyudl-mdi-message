require 'securerandom'
require 'multi_json'

module NYUDL::MDI::Message
  class Base
    def initialize
      h[:version]    = MESSAGE_STRUCTURE_VERSION
      h[:request_id] = SecureRandom.uuid
    end
    def version
      h[:version]
    end
    def to_json
      MultiJson.dump(h)
    end
    def request_id
      h[:request_id]
    end
    private
    def h
      @h ||= {}
    end
  end
end
