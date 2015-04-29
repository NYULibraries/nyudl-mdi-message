module NYUDL::MDI::Message
  class Base

    def version
      MESSAGE_STRUCTURE_VERSION
    end
    def to_json
      "{}"
    end
  end
end
