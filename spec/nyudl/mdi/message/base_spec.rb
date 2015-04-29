require 'spec_helper'

module NYUDL::MDI::Message
  describe Base do
    context 'when instantiated' do
      it 'should be the correct class' do
        expect(NYUDL::MDI::Message::Base.new).to be_an_instance_of(NYUDL::MDI::Message::Base)
      end
    end
  end
end
