module NYUDL::MDI::Message
  class Response < Base
    def start_time
      h[:start_time]
    end
    def start_time=(value)
      h[:start_time] = value
    end
  end
end
