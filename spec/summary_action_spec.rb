# frozen_string_literal: true

RSpec.describe SummaryAction do
  subject(:action) { described_class }

  let(:base) { "master" }
  let(:head) { "HEAD" }

  it "has a version number" do
    expect(SummaryAction::VERSION).not_to be_nil
  end

  it { expect(action.call(base, head)).to be(true) }
end
