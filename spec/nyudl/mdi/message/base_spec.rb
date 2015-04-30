require 'spec_helper'

module NYUDL::MDI::Message
  describe Base do
    context 'when instantiated' do
      it 'should be the correct class' do
        expect(NYUDL::MDI::Message::Base.new).to be_an_instance_of(NYUDL::MDI::Message::Base)
      end
    end
    describe '#to_json' do
      let(:json) { NYUDL::MDI::Message::Base.new.to_json }
      it 'should return valid JSON' do
        expect{ MultiJson.load(json) }.to_not raise_error
      end
      it 'should return the expected keys' do
        keys = %w(version request_id).sort
        expect(MultiJson.load(json).keys.sort).to be == keys
      end
    end
    describe '#version' do
      let(:version) { NYUDL::MDI::Message::Base.new.version }
      it 'should return the correct version' do
        expect(version).to be == '0.1.0'
      end
    end
    describe '#request_id' do
      let(:request_id) { NYUDL::MDI::Message::Base.new.request_id }
      it 'should return an id of the correct form' do
        pattern = '[a-z\d]{8}-[a-z\d]{4}-[a-z\d]{4}-[a-z\d]{4}-[a-z\d]{12}'
        regexp  = /\A#{pattern}\z/
        expect(request_id).to match(regexp)
      end
    end
  end
end
