"""Unit tests for the summary module."""

from unittest.mock import patch, mock_open, MagicMock
import pytest
from summary import generate_summary

@pytest.fixture
def mock_env_openai_key(monkeypatch):
    """Set the OPENAI_API_KEY environment variable to a test value"""
    monkeypatch.setenv("OPENAI_API_KEY", "test_api_key")

def test_generate_summary(_mock_env_openai_test_key):
    """Test the generate_summary function"""
    diff_content = "This is a test diff content."
    system_prompt_content = "This is a test system prompt."
    expected_summary = "This is a mocked summary content."

    m_open = mock_open()
    m_open.side_effect = [
        mock_open(read_data=diff_content).return_value,
        mock_open(read_data=system_prompt_content).return_value
    ]

    with patch("builtins.open", m_open) as mock_file, patch("openai.OpenAI") as mock_openai_client:
        mock_response = MagicMock()
        mock_response.choices = [MagicMock(message=MagicMock(content=expected_summary))]
        mock_openai_client.return_value.chat.completions.create.return_value = mock_response

        result = generate_summary("diff.txt")

        assert result == expected_summary
        mock_file.assert_any_call("diff.txt", "r", encoding="utf-8")
        mock_file.assert_any_call("system_prompt.txt", "r", encoding="utf-8")
        mock_openai_client.assert_called_with(api_key="test_api_key")
        mock_openai_client.return_value.chat.completions.create.assert_called_once_with(
            model="gpt-4o-mini",
            messages=[
                {"role": "user", "content": diff_content},
                {"role": "system", "content": system_prompt_content}
            ],
            temperature=0.3
        )

if __name__ == "__main__":
    pytest.main()
