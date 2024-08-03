# frozen_string_literal: true

module SummaryAction
  # Create a new class Diff to compare base and head
  class Diff
    def self.call(base, head)
      new(base, head).compare
    end

    # Initialize the class with base and head
    def initialize(base = "master", head = "HEAD")
      @base = base
      @head = head
    end

    # Create a method to compare the base and head
    def compare
      `git diff #{@base} #{@head}`
    end

    # Create a method to show the summary of the comparison
    def summary
      compare.split("\n").each do |line|
        puts line if line.start_with?("+", "-")
      end
    end
  end
end
