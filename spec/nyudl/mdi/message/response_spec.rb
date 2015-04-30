require 'spec_helper'

module NYUDL::MDI::Message
  describe Response do
    context 'when instantiated' do
      it 'should be the correct class' do
        expect(NYUDL::MDI::Message::Response.new).to be_an_instance_of(NYUDL::MDI::Message::Response)
      end
    end
    describe "#start_time" do
      let(:response) { NYUDL::MDI::Message::Response.new }
      context "when not assigned a value" do
        it "returns nil" do
          expect(response.start_time).to be_nil
        end
      end
      pending "when assigned a valid time"
      pending "when assigned an invalid time"
      pending "when assigned a non-UTC time"
    end
  end
end
