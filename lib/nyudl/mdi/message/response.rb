require 'timeliness'

module NYUDL::MDI::Message
  class Response < Base

    def start_time
      h[:start_time]
    end

    def start_time=(value)
      assert_iso8601_utc!(value)
      h[:start_time] = value
    end


    def end_time
      h[:end_time]
    end

    def end_time=(value)
      assert_iso8601_utc!(value)
      h[:end_time] = value
    end


    def outcome
      h[:outcome]
    end

    def outcome=(value)
      assert_valid_outcome!(value)
      h[:outcome] = value
    end


    private

    def assert_iso8601_utc!(value)
      unless Timeliness.parse(value, format: 'yyyy-mm-ddThh:nn:ssZ')
        raise ArgumentError, "non-UTC ISO-8601 time detected: #{value}"
      end
    end

    def assert_valid_outcome!(value)
      valid_values = %w(success error)
      unless valid_values.include?(value)
        raise ArgumentError, "invalid outcome detected: #{value}"
      end
    end

  end
end
