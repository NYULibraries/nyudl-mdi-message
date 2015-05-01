require 'spec_helper'
require 'time'

module NYUDL::MDI::Message
  describe Response do
    let(:response) { NYUDL::MDI::Message::Response.new }

    context 'when instantiated' do
      it 'should be the correct class' do
        expect(response).to be_an_instance_of(NYUDL::MDI::Message::Response)
      end
    end


    describe "#start_time" do
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
    end


    describe "#start_time=" do
      context "when assigned an invalid time" do
        it "raises an ArgumentError" do
          expect { response.start_time = 'foo' }.to raise_error(ArgumentError)
        end
      end

      context "when assigned a non-UTC time" do
        it "raises an ArgumentError" do
          time = Time.now.asctime
          expect { response.start_time = time }.to raise_error(ArgumentError)
        end
      end
    end



    describe "#end_time" do
      context "when not assigned a value" do
        it "returns nil" do
          expect(response.end_time).to be_nil
        end
      end

      context "when assigned a valid time" do
        it "returns the assigned time" do
          time = Time.now.utc.iso8601
          response.end_time = time
          expect(response.end_time).to be == "#{time}"
        end
      end
    end


    describe "#end_time=" do
      context "when assigned an invalid time" do
        it "raises an ArgumentError" do
          expect { response.end_time = 'foo' }.to raise_error(ArgumentError)
        end
      end

      context "when assigned a non-UTC time" do
        it "raises an ArgumentError" do
          time = Time.now.asctime
          expect { response.end_time  = time }.to raise_error(ArgumentError)
        end
      end
    end


    describe "#outcome" do
      context "when not assigned a value" do
        it "returns nil" do
          expect(response.outcome).to be_nil
        end
      end

      context "when assigned a valid outcome" do
        it "returns the assigned outcome" do
          response.outcome = 'success'
          expect(response.outcome).to be == 'success'
        end
      end
    end


    describe "#outcome=" do
      context "when assigned an invalid outcome" do
        it "raises an ArgumentError" do
          expect { response.outcome = 'foo' }.to raise_error(ArgumentError)
        end
      end
    end


    describe "#agent" do
      context "when not assigned a value" do
        it "returns nil" do
          expect(response.agent).to be_nil
        end
      end

      context "when assigned a valid agent" do
        it "returns the assigned agent" do
          agent = {name: 'sha256deep', version: '4.3', host: 'rsw1.dlib.nyu.edu'}
          response.agent = agent
          expect(response.agent).to be == agent
        end
      end
    end


    describe "#agent=" do
      context "when assigned an invalid agent" do
        context "and the agent is not a Hash" do
          it "raises an ArgumentError" do
            expect { response.agent = 21 }.to raise_error(ArgumentError)
          end
        end

        context "and the agent Hash does not have the expected keys" do
          it "raises an ArgumentError" do
            expect { response.agent = {foo: 'bar'} }.to raise_error(ArgumentError)
          end
        end

        context "and the agent Hash does not have values for every key" do
          it "raises an ArgumentError" do
            agent = {name: 'sha256deep', version: '  ', host: 'rsw1.dlib.nyu.edu'}
            expect { response.agent = agent  }.to raise_error(ArgumentError)
          end
        end
      end
    end


    describe "#data" do
      context "when not assigned a value" do
        it "returns nil" do
          expect(response.data).to be_nil
        end
      end
    end

    describe "#data=" do
      context "when assigned a valid data" do
        it "returns the assigned data" do
          data = "this is some awesome data!"
          response.data = data
          expect(response.data).to be == data
        end
      end
    end
  end
end
