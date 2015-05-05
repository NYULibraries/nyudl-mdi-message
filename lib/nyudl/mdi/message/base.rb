require 'securerandom'
require 'multi_json'
require 'validatable'

module NYUDL::MDI::Message
  class Base
    include Validatable


    def initialize(incoming = {})
      h[:version]    = MESSAGE_STRUCTURE_VERSION
      h[:request_id] = SecureRandom.uuid
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


    def to_json
      MultiJson.dump(h)
    end


    private
    def h
      @h ||= {}
    end
  end
end
