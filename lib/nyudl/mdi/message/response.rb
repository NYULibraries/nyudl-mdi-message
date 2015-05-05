require 'timeliness'

module NYUDL
  module MDI
    module Message
      # Response contains attributes and methods used to return the
      # results of a requested MDI operation
      class Response < Base
        validates_true_for :time_values, logic: proc { times_valid?   }
        validates_true_for :outcome,     logic: proc { outcome_valid? }
        validates_true_for :agent,       logic: proc { agent_valid?   }

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
          check_time_format(start_time)
          check_time_format(end_time)
          check_time_relationship
          errors.on(:time_values).nil?
        end

        def check_time_relationship
          emsg = 'start_time must be <= end_time'
          errors.add :time_values, emsg  unless start_time <= end_time
        end

        def check_time_format(time)
          emsg = "non-UTC ISO-8601 time detected: #{time}"
          errors.add :time_values, emsg unless iso8601_utc?(time)
        end

        def iso8601_utc?(time)
          Timeliness.parse(time, format: 'yyyy-mm-ddThh:nn:ssZ')
        end

        def outcome_valid?
          emsg = "invalid outcome: #{outcome}"
          errors.add :outcome, emsg unless %w(success error).include?(outcome)
          errors.on(:outcome).nil?
        end

        def agent_valid?
          if agent.is_a?(Hash)
            check_agent_keys
            check_agent_values
          else
            errors.add :agent, 'agent must be a Hash' unless agent.is_a?(Hash)
          end

          errors.on(:agent).nil?
        end

        def check_agent_keys
          emsg = "invalid keys: #{agent.keys}"
          errors.add :agent, emsg unless agent.keys.sort == required_keys.sort
        end

        def check_agent_values
          emsg = "all keys must have values: #{agent}"
          values = (agent.values.reject { |a| a.strip.empty? })
          errors.add :agent, emsg unless values.length == required_keys.length
        end

        def required_keys
          [:name, :version, :host]
        end
      end
    end
  end
end
