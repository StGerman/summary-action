# frozen_string_literal: true

require_relative "summary_action/version"

# SummaryAction getting diff and generate summary based on it
module SummaryAction
  class Error < StandardError; end

  def self.call(_base, _head)
    true
  end
end
