require 'timeliness'

module NYUDL::MDI::Message
  class Response < Base
    def start_time
      h[:start_time]
    end
    def start_time=(value)

      unless(Timeliness.parse(value, format: 'yyyy-mm-ddThh:nn:ssZ'))
        raise ArgumentError, "non-UTC ISO-8601 time detected: #{value}"
      end

      h[:start_time] = value
    end
  end
end
