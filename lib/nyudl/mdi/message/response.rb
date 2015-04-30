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


    def end_time
      h[:end_time]
    end

    def end_time=(value)

      unless(Timeliness.parse(value, format: 'yyyy-mm-ddThh:nn:ssZ'))
        raise ArgumentError, "non-UTC ISO-8601 time detected: #{value}"
      end

      h[:end_time] = value
    end
  end
end
