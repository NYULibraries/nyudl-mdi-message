module NYUDL::MDI::Message
  class Response < Base
    def start_time
      h[:start_time]
    end
  end
end
