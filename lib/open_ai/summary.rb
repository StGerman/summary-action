# frozen_string_literal: true

require_relative "client"

module OpenAI
  # Create a Summary from the OpenAI API
  class Summary < Client
    def messages(prompt)
      super << { role: "system", content: system_prompt }
    end

    # Override system prompt to include tech writer instructions
    # https://platform.openai.com/docs/guides/chat-completions/message-roles
    def system_prompt
      @system_prompt ||= <<~PROMPT
        You are a world-class technical writer. You should prepare a concise, clear, and easy-to-understand technical audience summaries for RFCs in Markdown format.
        Extract from the original user input, including, but not limited to, the following data:
        - Problem statement and the goal of the code changes
        - List of requirements
        - High-level overview of changes in mermaidjs diagrams
        - List of references and links

        It's crucial to include only information from the user input and nothing else
      PROMPT
    end
  end
end
