# frozen_string_literal: true

require "spec_helper"
require_relative "../../lib/open_ai/summary"
require "vcr"
require "webmock/rspec"

RSpec.describe OpenAI::Summary do
  describe "#send_request", :vcr do
    let(:client) { described_class.new }
    let(:prompt) do
      '-expect(response.status).to eq(500)
      +expect(response.status).to eq(200)'
    end

    it "successfully sends a request to the OpenAI API" do
      VCR.use_cassette("openai_summary_request") do
        response = client.send_request(prompt)
        expect(response.status).to eq(200)
        expect(response.body).to include("choices")
      end
    end

    it "handles errors gracefully" do
      VCR.use_cassette("openai_summary_error") do
        allow(client).to receive(:post).and_raise(Faraday::ConnectionFailed.new("Connection failed"))
        expect { client.send_request(prompt) }.to raise_error(Faraday::ConnectionFailed)
      end
    end
  end
end
