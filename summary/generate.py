"""
Description: This script generates a summary of the user input provided in the diff file.
The user input is combined with a system prompt to generate a summary using the OpenAI API.
The generated summary is then printed to the console.
Usage: python summary.py <user_input_file>
"""

import os
import sys
import openai # Import the OpenAI library
import google.generativeai as genai

def gemini_summary(api_key, _user_input, _system_prompt):
    """
    Generates a summary using the Gemini API.
    Args:
        api_key (str): The OpenAI API key.
        user_input (str): The user input to summarize.
        system_prompt (str): The system prompt to use for summarization.
    Returns:
        str: The generated summary of the user input.
    """

    genai.configure(api_key=api_key)
    model = genai.GenerativeModel('gemini-1.5-pro-latest')
    response = model.generate_content(
        "Tell me a story about a dark magic code",
        generation_config=genai.types.GenerationConfig(
            # Only one candidate for now.
            candidate_count=1,
            stop_sequences=["x"],
            max_output_tokens=20,
            temperature=1.0,
        ),
    )

    return response.text

def openai_summary(api_key, user_input, system_prompt):
    """
    Generates a summary using the OpenAI API.
    Args:
        api_key (str): The OpenAI API key.
        user_input (str): The user input to summarize.
        system_prompt (str): The system prompt to use for summarization.
    Returns:
        str: The generated summary of the user input.
    """
    client = openai.OpenAI(api_key=api_key)

    model_name = "gpt-4o"

    messages = [
        {
            "role": "user",
            "content": user_input,
        },
        {
            "role": "system",
            "content": system_prompt,
        },
    ]

    response = client.chat.completions.create(
        model=model_name, messages=messages, temperature=0.3
    )

    return response.choices[0].message.content

def generate_summary(diff_file_path):
    """
    Generates a summary of the user input provided in the diff file.
    The user input is combined with a system prompt to generate a summary using the OpenAI API.
    Args:
        diff_file (str): The path to the file containing the user input.
    Returns:
        str: The generated summary of the user input.
    """
    with open(diff_file_path, "r", encoding="utf-8") as f:
        user_input = f.read()

    with open("system_prompt.txt", "r", encoding="utf-8") as f:
        system_prompt = f.read()

    open_ai_api_key = os.environ.get("OPENAI_API_KEY")
    gemini_api_key = os.environ.get("GEMINI_API_KEY")

    if open_ai_api_key:
        return openai_summary(open_ai_api_key, user_input, system_prompt)

    if gemini_api_key:
        return gemini_summary(gemini_api_key, user_input, system_prompt)
    else:
        raise ValueError("No OpenAI or Gemini API key provided.")

if __name__ == "__main__":
    # Ensure the correct number of command-line arguments
    if len(sys.argv) < 2:
        print("Usage: python script.py <user_input_file>")
        sys.exit(1)

    diff_file = sys.argv[1]
    summary = generate_summary(diff_file)
    print(summary)
