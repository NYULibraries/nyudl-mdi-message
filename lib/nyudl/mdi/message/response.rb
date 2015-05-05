require 'timeliness'

module NYUDL::MDI::Message
  class Response < Base

    validates_true_for :time_values, :logic => Proc.new { times_valid? }
    validates_true_for :outcome,     :logic => Proc.new { outcome_valid? }

    def initialize(incoming)
      super
      [:outcome, :start_time, :end_time, :outcome, :agent, :data].each do |k|
        h[k] = incoming[k]
      end
    end

    def start_time
      h[:start_time]
    end

    def start_time=(value)
      h[:start_time] = value
    end


    def end_time
      h[:end_time]
    end

    def end_time=(value)
      h[:end_time] = value
    end


    def outcome
      h[:outcome]
    end

    def outcome=(value)
      h[:outcome] = value
    end


    def agent
      h[:agent]
    end

    def agent=(value)
      assert_valid_agent!(value)
      h[:agent] = value
    end


    def data
      h[:data]
    end

    def data=(value)
      h[:data] = value
    end



    private

    def times_valid?
      errors.add :time_values, "non-UTC ISO-8601 time detected: #{start_time}" unless iso8601_utc?(start_time)
      errors.add :time_values, "non-UTC ISO-8601 time detected: #{end_time}"   unless iso8601_utc?(end_time)
      errors.add :time_values, "start_time must be <= end_time"                unless start_time <= end_time

      errors.on(:time_values).nil?
    end

    def iso8601_utc?(time)
      Timeliness.parse(time, format: 'yyyy-mm-ddThh:nn:ssZ')
    end


    def outcome_valid?
      %w(success error).include?(outcome)
    end


    def assert_valid_agent!(agent)
      raise ArgumentError, "agent must be a Hash" unless agent.is_a?(Hash)

      required_keys = [ :name, :version , :host ]
      unless agent.keys.sort == required_keys.sort
        raise ArgumentError, "invalid keys: #{agent.keys}"
      end

      values = (agent.values.reject {|a| a.strip.empty? })
      unless values.length == required_keys.length
        raise ArgumentError, "all keys must have values: #{agent}"
      end
    end
  end
end
