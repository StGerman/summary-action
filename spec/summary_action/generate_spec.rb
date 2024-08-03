# frozen_string_literal: true

require "spec_helper"
require_relative "../../lib/summary_action/generate"
require_relative "../../lib/open_ai/summary"

RSpec.describe SummaryAction::Generate do
  let(:diff_output) do
    '-expect(response.status).to eq(500)
    +expect(response.status).to eq(200)'
  end
  let(:summary_agent) { instance_double(OpenAI::Summary) }

  describe ".call" do
    it "calls the summary method on a new instance" do
      generate_instance = instance_double(described_class)
      expect(described_class).to receive(:new).with(diff_output, agent: summary_agent).and_return(generate_instance)
      expect(generate_instance).to receive(:summary)

      described_class.call(diff_output, agent: summary_agent)
    end
  end

  describe "#summary" do
    it "sends a request to the summary agent" do
      generate_instance = described_class.new(diff_output, agent: summary_agent)
      expect(summary_agent).to receive(:send_request).with(diff_output)

      generate_instance.summary
    end
  end
end
