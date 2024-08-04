"""
Description: This script generates a summary of the user input provided in the diff file.
The user input is combined with a system prompt to generate a summary using the OpenAI API.
The generated summary is then printed to the console.
Usage: python summary.py <user_input_file>
"""

import os
import sys
import openai


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

    client = openai.OpenAI(api_key=os.environ.get("OPENAI_API_KEY"))

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


if __name__ == "__main__":
    # Ensure the correct number of command-line arguments
    if len(sys.argv) < 2:
        print("Usage: python script.py <user_input_file>")
        sys.exit(1)

    diff_file = sys.argv[1]
    summary = generate_summary(diff_file)
    print(summary)
