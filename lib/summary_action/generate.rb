# frozen_string_literal: true

require_relative "../open_ai/summary"
require "pry"

module SummaryAction
  # Take the diff output and generate a summary
  class Generate
    def self.call(diff_output, agent: )
      new(diff_output).summary
    end

    def initialize(diff_output, agent: )
      @diff_output = diff_output
      @summary_agent = agent
    end

    def summary
      responce = summary_agent.send_request(@diff_output)
      responce&.success? ? responce.body["choices"]&.first&.dig("message", "content") : nil
    end
  end
end
