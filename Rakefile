# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]

require_relative "lib/summary_action/diff"

desc "Generate the diff between two branches"
task :diff, [:base, :head] do |_t, args|
  base = ENV["base"] || args[:base] || "master"
  head = ENV["head"] || args[:head] || "HEAD"

  SummaryAction::Diff.call(base, head)
end

desc "Generate a summary from the input"
task :summary, [:input] do |_t, args|
  input = ENV["summary_input"] || args[:input]

  require_relative "lib/summary_action/generate"
  summary = SummaryAction::Generate.call(input)

  summary.split("\n").each { |line| puts line }
end

desc "Generate a summary of the diff"
task :summary do |_t|
  require_relative "lib/summary_action/generate"
  require_relative "lib/open_ai/summary"

  diff_output = SummaryAction::Diff.call("master", "HEAD")
  summary = SummaryAction::Generate.call(diff_output)

  summary.split("\n").each { |line| puts line }
end
