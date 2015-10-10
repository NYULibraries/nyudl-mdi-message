require 'spec_helper'

module NYUDL
  module MDI
    module Message
      describe Base do
        context 'when instantiated' do
          it 'should be the correct class' do
            expect(Base.new).to be_an_instance_of(NYUDL::MDI::Message::Base)
          end
        end
        describe '#to_json' do
          let(:json) { Base.new.to_json }
          it 'should return valid JSON' do
            expect { MultiJson.load(json) }.to_not raise_error
          end
          it 'should return the expected keys' do
            keys = %w(version request_id params).sort
            expect(MultiJson.load(json).keys.sort).to be == keys
          end
        end
        describe '#version' do
          let(:version) { Base.new.version }
          it 'should return the correct version' do
            expect(version).to be == '0.1.0'
          end
          it 'should preserve the version provided to the constructor' do
            expect(Base.new(version: '0.0.0').version).to be == '0.0.0'
          end
        end
        describe '#request_id' do
          let(:request_id) { Base.new.request_id }
          it 'should return an id of the correct form' do
            pattern = '[a-z\d]{8}-[a-z\d]{4}-[a-z\d]{4}-[a-z\d]{4}-[a-z\d]{12}'
            regexp  = /\A#{pattern}\z/
            expect(request_id).to match(regexp)
          end
          context 'when instantiated without a request_id value' do
            it 'returns a unique request_id' do
              expect(Base.new.request_id).to_not be == request_id
            end
          end
          context 'when instantiated with a request_id value' do
            it 'returns the assigned value' do
              expect(Base.new(request_id: request_id).request_id).to be == request_id
            end
          end
        end
        describe '#params' do
          context 'when no params hash provided to constructor' do
            let(:empty) { Base.new.params }
            it 'should return an empty hash' do
              expect(empty).to be_nil
            end
          end
          context 'when a params hash provided to constructor' do
            test_params = { a: 'a', b: 'b' }
            let(:populated) { Base.new(params: test_params).params }
            it 'should return the provided params hash' do
              expect(populated).to be == test_params
            end
          end
        end
        describe '#params=' do
          context 'when a value is assigned that responds to #to_h' do
            test_params = { c: 'c', d: 'd' }
            b = Base.new()
            b.params = test_params
            let(:assigned) { b.params }
            it 'should return the assigned params hash' do
              expect(assigned).to be == test_params
            end
          end
        end
        describe '#valid?' do
          let(:result) { Base.new.valid? }
          it 'should be true' do
            expect(result).to be == true
          end
        end
        describe '#errors' do
          let(:errors) { Base.new.errors }
          it 'should be empty' do
            expect(errors).to be_empty
          end
        end
      end
    end
  end
end
