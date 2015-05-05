require 'spec_helper'

module NYUDL
  module MDI
    module Message
      describe Request do
        context 'when instantiated' do
          it 'should be the correct class' do
            klass = NYUDL::MDI::Message::Request
            expect(Request.new).to be_an_instance_of(klass)
          end
        end
      end
    end
  end
end
