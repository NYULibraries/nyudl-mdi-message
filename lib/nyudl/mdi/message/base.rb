require 'securerandom'

module NYUDL::MDI::Message
  class Base
    def version
      MESSAGE_STRUCTURE_VERSION
    end
    def to_json
      "{}"
    end
    def request_id
      @request_id ||= SecureRandom.uuid
    end
  end
end
