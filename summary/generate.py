"""
Description: This script generates a summary of the user input provided in the diff file.
The user input is combined with a system prompt to generate a summary using the OpenAI API.
The generated summary is then printed to the console.
Usage: python summary.py <user_input_file>
"""

import os
import sys
import openai
import google.generativeai as genai

def gemini_summary(api_key, user_input, system_prompt):
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
    model = genai.GenerativeModel(
        model_name="gemini-1.5-pro",
        system_instruction=system_prompt
        )

    response = model.generate_content(
        user_input,
        generation_config=genai.types.GenerationConfig(
            candidate_count=1,
            max_output_tokens=2000,
            temperature=0.3,
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

    model_name = "gpt-4o-mini"

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

def generate_summary(diff_file_path, api_key, provider="openai"):
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

    with open("system_prompt.mdown", "r", encoding="utf-8") as f:
        system_prompt = f.read()

    if provider == "openai":
        return openai_summary(api_key, user_input, system_prompt)

    if provider == "gemini":
        return gemini_summary(api_key, user_input, system_prompt)

    raise ValueError(f"Invalid provider: {provider}")

if __name__ == "__main__":
    # Ensure the correct number of command-line arguments
    if len(sys.argv) < 3:
        print("Usage: python script.py <user_input_file>")
        sys.exit(1)

    # Get the user input file path from the command-line arguments
    diff_file = sys.argv[1]
    provider = sys.argv[2]

    # Get the OpenAI API key from the environment variables
    open_ai_api_key = os.environ.get("OPENAI_API_KEY")
    gemini_api_key = os.environ.get("GEMINI_API_KEY")

    if provider == "openai":
        summary = generate_summary(diff_file, open_ai_api_key, provider="openai")
    elif provider == "gemini":
        summary = generate_summary(diff_file, gemini_api_key, provider="gemini")
    else:
        print("Invalid provider. Please provide either 'openai' or 'gemini'.")
        sys.exit(1)

    print(summary)
