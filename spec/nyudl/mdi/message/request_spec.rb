require 'spec_helper'

module NYUDL::MDI::Message
  describe Request do
    context 'when instantiated' do
      it 'should be the correct class' do
        expect(Request.new).to be_an_instance_of(NYUDL::MDI::Message::Request)
      end
    end
  end
end
