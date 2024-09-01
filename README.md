# AI-Powered Summary Generation for Pull Requests

## Goal
This GitHub workflow introduces a new feature that automates the generation of summaries for code changes in pull requests using AI models from OpenAI or Gemini. The goal is to enhance the documentation of pull requests, making it easier for reviewers to understand the modifications made. This feature leverages GitHub Actions to trigger the summary generation process whenever a pull request is created or updated.

### Key Features
- The project automates the process of summarizing changes in pull requests, making it easier for reviewers to understand the modifications.
- It integrates with GitHub Actions for continuous integration and deployment, ensuring that summaries are generated and tested automatically.
- The use of OpenAI's API allows for intelligent summarization based on the context of the changes.

## Dependencies
- `openai`: Required for accessing the OpenAI API for summary generation.
- `google-generativeai`: Required for accessing the Gemini API for summary generation.

## References and Links
- [GitHub Actions Documentation](https://docs.github.com/ru/actions)
- [Gemini API Documentation](https://www.example.com/gemini-api)
- [OpenAI API Documentation](https://platform.openai.com/docs/api-reference)
