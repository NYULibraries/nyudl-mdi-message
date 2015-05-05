require 'timeliness'

module NYUDL::MDI::Message
  class Response < Base

    validates_true_for :time_values, logic: Proc.new { times_valid?   }
    validates_true_for :outcome,     logic: Proc.new { outcome_valid? }
    validates_true_for :agent,       logic: Proc.new { agent_valid?   }


    # define getters/setters that access underlying hash
    KEYS = :outcome, :start_time, :end_time, :outcome, :agent, :data
    KEYS.each do |k|
      # getter
      define_method("#{k}") do
        h[k]
      end
      # setter
      define_method("#{k}=") do |argument|
        h[k] = argument
      end
    end


    def initialize(incoming)
      super
      KEYS.each do |k|
        h[k] = incoming[k]
      end
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
      errors.add :outcome, "invalid outcome: #{outcome}" unless %w(success error).include?(outcome)
      errors.on(:outcome).nil?
    end


    def agent_valid?
      required_keys = [ :name, :version , :host ]

      if agent.is_a?(Hash)
        unless agent.keys.sort == required_keys.sort
          errors.add :agent, "invalid keys: #{agent.keys}"
        end

        values = (agent.values.reject {|a| a.strip.empty? })
        unless values.length == required_keys.length
          errors.add :agent, "all keys must have values: #{agent}"
        end
      else
        errors.add :agent, "agent must be a Hash" unless agent.is_a?(Hash)
      end

      errors.on(:agent).nil?
    end

  end
end
