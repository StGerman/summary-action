# frozen_string_literal: true

require "open_ai/client"

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
      @diff_output.split("\n").each do |line|
        puts line if line.start_with?("+", "-")
      end
    end

    private

    def chat_gpt_client
      @chat_gpt_client ||= OpenAI::Client.new(ENV.fetch("OPENAI_API_KEY"))
    end
  end
end
