require 'securerandom'

module NYUDL::MDI::Message
  class Base
    def initialize
      h[:version] = MESSAGE_STRUCTURE_VERSION
    end
    def version
      h[:version]
    end
    def to_json
      "{}"
    end
    def request_id
      @request_id ||= SecureRandom.uuid
    end
    private
    def h
      @h ||= {}
    end
  end
end
