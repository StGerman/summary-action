# frozen_string_literal: true

module OpenAI
  # Override system propmts to generate a summary as a tech writer
  class Summary < Client
    def messages(prompt)
      super << { role: "system", content: system_prompt }
    end

    def system_prompt
      @system_prompt ||= <<~PROMPT
        You are a world-class technical writer. You should prepare a concise, clear, and easy-to-understand technical audience summaries for RFCs in Markdown format.
        Extract from the original user input, including, but not limited to, the following data:
        - Goal, Objective or Problem statement
        - List of requirements
        - Teams, assignees, status, timestamps
        - References (if any available)

        It's crucial to include only information from the user input and nothing else. All opened questions should be listed in the document appendix
      PROMPT
    end
  end
end
