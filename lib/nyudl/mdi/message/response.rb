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


    def agent
      h[:agent]
    end

    def agent=(value)
      assert_valid_agent!(value)
      h[:agent] = value
    end


    private

    def assert_iso8601_utc!(time)
      unless Timeliness.parse(time, format: 'yyyy-mm-ddThh:nn:ssZ')
        raise ArgumentError, "non-UTC ISO-8601 time detected: #{time}"
      end
    end

    def assert_valid_outcome!(outcome)
      valid_outcomes = %w(success error)
      unless valid_outcomes.include?(outcome)
        raise ArgumentError, "invalid outcome detected: #{outcome}"
      end
    end

    def assert_valid_agent!(agent)

      raise ArgumentError, "agent must be a Hash" unless agent.is_a?(Hash)

      required_keys = [ :name, :version , :host ].sort
      unless agent.keys.sort == required_keys
        raise ArgumentError, "invalid keys: #{agent.keys}"
      end

      values = (agent.values.reject {|a| a.strip.empty? })
      unless values.length == required_keys.length
        raise ArgumentError, "all keys must have values: #{agent}"
      end
    end
  end
end
