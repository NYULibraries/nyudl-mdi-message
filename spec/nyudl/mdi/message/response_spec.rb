require 'spec_helper'
require 'time'

module NYUDL
  module MDI
    module Message
      describe Response do
        def valid_attributes
          {
            request_id: 'f2bed5f1-a756-4da7-af00-0d479e0da099',
            outcome:    'success',
            start_time: Time.now.utc.iso8601,
            end_time:   Time.now.utc.iso8601,
            agent:      { name:    'sha256deep',
                          version: '4.3',
                          host:    'rsw1.dlib.nyu.edu' },
            data:       'this is some data.'
          }
        end

        def build(hash = {})
          result = valid_attributes
          hash.each_pair { |k, v| result[k] = v }
          Response.new(result)
        end

        let(:response) { build }

        context 'when instantiated' do
          it 'should be the correct class' do
            expect(response).to be_an_instance_of(NYUDL::MDI::Message::Response)
          end
          context 'with valid attributes' do
            it 'should be valid' do
              expect(response).to be_valid
            end
          end
        end

        describe '#start_time' do
          context 'when not assigned a value' do
            it 'returns nil' do
              response = build(start_time: nil)
              expect(response.start_time).to be_nil
            end
          end

          context 'when assigned a valid time' do
            it 'returns the assigned time' do
              time = Time.now.utc.iso8601
              response.start_time = time
              expect(response.start_time).to be == "#{time}"
            end
          end
        end

        describe '#start_time=' do
          context 'when assigned an invalid time' do
            it 'should not be valid' do
              response.start_time = 'foo'
              expect(response).to_not be_valid
            end
          end

          context 'when assigned a non-UTC time' do
            it 'should not be valid' do
              response.start_time = Time.now.asctime
              expect(response).to_not be_valid
            end
          end
        end

        describe '#end_time' do
          context 'when not assigned a value' do
            it 'returns nil' do
              response = build(end_time: nil)
              expect(response.end_time).to be_nil
            end
          end

          context 'when assigned a valid time' do
            it 'returns the assigned time' do
              time = Time.now.utc.iso8601
              response.end_time = time
              expect(response.end_time).to be == "#{time}"
            end
          end

          context 'when assigned a time earlier than the start_time' do
            it 'should not be valid' do
              time = Time.new(2003).utc.iso8601
              response.end_time = time
              expect(response).to_not be_valid
            end
          end
        end

        describe '#end_time=' do
          context 'when assigned an invalid time' do
            it 'should not be valid' do
              response.end_time = 'foo'
              expect(response).to_not be_valid
            end
          end

          context 'when assigned a non-UTC time' do
            it 'should not be valid' do
              response.end_time = Time.now.asctime
              expect(response).to_not be_valid
            end
          end
        end

        describe '#outcome' do
          context 'when not assigned a value' do
            it 'returns nil' do
              response = build(outcome: nil)
              expect(response.outcome).to be_nil
            end
          end

          context 'when assigned a valid outcome' do
            it 'returns the assigned outcome' do
              response.outcome = 'success'
              expect(response.outcome).to be == 'success'
            end
          end
        end

        describe '#outcome=' do
          context 'when assigned an invalid outcome' do
            it 'should not be valid' do
              response.outcome = 'foo'
              expect(response).to_not be_valid
            end
          end
        end

        describe '#agent' do
          context 'when not assigned a value' do
            it 'returns nil' do
              response = build(agent: nil)
              expect(response.agent).to be_nil
            end
          end

          context 'when assigned a valid agent' do
            it 'returns the assigned agent' do
              agent = { name:    'sha256deep',
                        version: '4.3',
                        host:    'rsw5.dlib.nyu.edu' }
              response.agent = agent
              expect(response.agent).to be == agent
            end
          end
        end

        describe '#agent=' do
          context 'when assigned an invalid agent' do
            context 'and the agent is not a Hash' do
              it 'should not be valid' do
                response.agent = 21
                expect(response).to_not be_valid
              end

              context 'and the agent Hash does not have the expected keys' do
                it 'should not be valid' do
                  response.agent = { foo: 'bar' }
                  expect(response).to_not be_valid
                end
              end

              context 'and the agent Hash does not have values for every key' do
                it 'should not be valid' do
                  response.agent = { name:    'sha256deep',
                                     version: '  ',
                                     host: 'rsw1.dlib.nyu.edu' }
                  expect(response).to_not be_valid
                end
              end
            end
          end
        end

        describe '#data' do
          context 'when not assigned a value' do
            it 'returns nil' do
              response = build(data: nil)
              expect(response.data).to be_nil
            end
          end
        end

        describe '#data=' do
          context 'when assigned a valid data' do
            it 'returns the assigned data' do
              data = 'this is some awesome data!'
              response.data = data
              expect(response.data).to be == data
            end
          end
        end

        describe '#request_id' do
          context 'when instantiated without a request_id value' do
            it 'returns a unique request_id' do
              response = build(request_id: nil)
              expect(response.request_id).to_not be == valid_attributes[:request_id]
            end
          end

          context 'when instantiated without a request_id value' do
            it 'returns the assigned value' do
              response = build()
              expect(response.request_id).to be == valid_attributes[:request_id]
            end
          end
        end
      end
    end
  end
end
