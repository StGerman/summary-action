# frozen_string_literal: true

require "faraday"

module OpenAI
  # Create a Client for OpenAI API base on Faraday gem
  class Client < Faraday::Connection
    ApiKeyNotSet = Class.new(StandardError) do
      def message
        "OPENAI_API_KEY is not set"
      end
    end

    OPENAI_API_KEY = ENV.fetch("OPENAI_API_KEY", nil).freeze
    MODEL = "gpt-4o-mini"
    # Initialize the client with the API key
    def initialize
      super(url: "https://api.openai.com/v1") do |faraday|
        faraday.headers["Authorization"] = "Bearer #{OPENAI_API_KEY}"
        faraday.request :json
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end
    end

    # Send a request to the OpenAI API
    def send_request(prompt)
      post("chat/completions", {
             model: MODEL,
             messages: [{ role: "user", content: prompt }],
             temperature: 0.5
           })
    end
  end
end
