require 'spec_helper'

module NYUDL::MDI::Message
  describe Response do
    context 'when instantiated' do
      it 'should be the correct class' do
        expect(NYUDL::MDI::Message::Response.new).to be_an_instance_of(NYUDL::MDI::Message::Response)
      end
    end
  end
end
