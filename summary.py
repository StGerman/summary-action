import os
import sys
import openai

def generate_summary(diff_file):
    with open(diff_file, "r") as f:
        user_input = f.read()

    with open("system_prompt.txt", "r") as f:
        system_prompt = f.read()

    client = openai.OpenAI(api_key=os.environ.get("OPENAI_API_KEY"))

    GPT_MODEL = "gpt-4o-mini"

    messages = [
        {
            "role": "user",
            "content": user_input,
        },
        {
            "role": "system",
            "content": system_prompt,
        }
    ]

    response = client.chat.completions.create(
        model=GPT_MODEL,
        messages=messages,
        temperature=0.3
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
