require 'spec_helper'
require_relative '../../lib/summary_action/generate'
require_relative '../../lib/open_ai/summary'

RSpec.xdescribe SummaryAction::Generate do
  describe ".call" do
    it "calls the summary method on a new instance" do
      diff_output = "some diff output"
      generate_instance = instance_double(SummaryAction::Generate)
      expect(SummaryAction::Generate).to receive(:new).with(diff_output).and_return(generate_instance)
      expect(generate_instance).to receive(:summary)

      SummaryAction::Generate.call(diff_output)
    end
  end

  describe "#summary" do
    it "sends a request to the summary agent" do
      diff_output = "some diff output"
      summary_agent = instance_double(OpenAI::Summary)
      generate_instance = SummaryAction::Generate.new(diff_output)
      allow(generate_instance).to receive(:summary_agent).and_return(summary_agent)
      expect(summary_agent).to receive(:send_request).with(diff_output)

      generate_instance.summary
    end
  end
end
