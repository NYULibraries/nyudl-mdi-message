require 'spec_helper'
require 'time'

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
      context "when assigned a valid time" do
        it "returns the assigned time" do
          time = Time.now.utc.iso8601
          response.start_time = time
          expect(response.start_time).to be == "#{time}"
        end
      end
      pending "when assigned an invalid time"
      pending "when assigned a non-UTC time"
    end
  end
end
