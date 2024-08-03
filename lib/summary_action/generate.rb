# frozen_string_literal: true

require_relative "../open_ai/client"
require "pry"

module SummaryAction
  # Take the diff output and generate a summary
  class Generate
    def self.call(diff_output)
      new(diff_output).summary
    end

    def initialize(diff_output)
      @diff_output = diff_output
    end

    def summary
      responce = summary_agent.send_request(@diff_output)
      responce&.success? ? responce.body["choices"]&.first&.dig("message", "content") : nil
    end

    private

    def summary_agent
      @summary_agent ||= OpenAI::Summary.new
    end
  end
end
