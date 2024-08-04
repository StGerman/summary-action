#! /usr/bin/env bash

# Gett input from the file and call OpanAI API to get the summary of the text

# Get the input from the file
input=$(cat $1)

# Get system prompt tech writer instructions
system_prompt=$(cat system_prompt.txt)

# Call the OpenAI API to get the summary of the text
curl -X "POST" "https://api.openai.com/v1/chat/completions" \
      -H "Content-Type: application
      -H "Authorization: Bearer $OPENAI_API_KEY
      -d $'{
        "model": "gpt-4o-mini",
        messages: [{
          role: "system",
          content: "The following is a summary of the text."
        }, {
          role: "user",
          content: "'$input'"
        }],
        "max_tokens": 100,
        "temperature": 0.5
      }'
