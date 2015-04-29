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
    end
    describe '#version' do
      let(:version) { NYUDL::MDI::Message::Base.new.version }
      it 'should return the correct version' do
        expect(version).to be == '0.1.0'
      end
    end
  end
end
