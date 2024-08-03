# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]

require_relative "lib/summary_action/diff"

desc "Make a diff summary rake diff[master,HEAD]"
task :diff, [:base, :head] do |_t, args|
  base = ENV["base"] || args[:base] || "master"
  head = ENV["head"] || args[:head] || "HEAD"

  SummaryAction::Diff.call(base, head)
end
