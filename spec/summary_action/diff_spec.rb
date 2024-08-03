# frozen_string_literal: true

require "spec_helper"
require_relative "../../lib/summary_action/diff"

RSpec.describe SummaryAction::Diff do
  describe ".call" do
    let(:base) { "master" }
    let(:head) { "HEAD" }
    let(:diff_instance) { instance_double(described_class) }

    before do
      allow(described_class).to receive(:new).with(base, head).and_return(diff_instance)
      allow(diff_instance).to receive(:compare).and_return("mocked diff output")
    end

    it "initializes a new Diff instance and calls compare" do
      described_class.call(base, head)
      expect(described_class).to have_received(:new).with(base, head)
      expect(diff_instance).to have_received(:compare)
    end
  end

  describe "#initialize" do
    it "initializes with default values if none are provided" do
      diff = described_class.new
      expect(diff.instance_variable_get(:@base)).to eq("master")
      expect(diff.instance_variable_get(:@head)).to eq("HEAD")
    end

    context "when base and head values are provided" do
      let(:custom_base) { "develop" }
      let(:custom_head) { "feature-branch" }

      it "accepts custom base and head values" do
        diff = described_class.new(custom_base, custom_head)

        expect(diff.instance_variable_get(:@base)).to eq(custom_base)
        expect(diff.instance_variable_get(:@head)).to eq(custom_head)
      end
    end
  end

  describe "#compare" do
    it "executes a git diff command with the provided base and head" do
      diff = described_class.new("develop", "feature-branch")
      allow(diff).to receive(:`).with("git diff develop feature-branch").and_return("diff output")
      expect(diff.compare).to eq("diff output")
    end
  end

  describe "#summary" do
    it 'prints lines starting with "+" or "-" from the diff output' do
      diff = described_class.new
      allow(diff).to receive(:compare).and_return("+added line\n unchanged line\n-removed line")
      expect { diff.summary }.to output("+added line\n-removed line\n").to_stdout
    end
  end
end
