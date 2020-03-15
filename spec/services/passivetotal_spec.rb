# frozen_string_literal: true

RSpec.describe Ukemi::Services::PassiveTotal, :vcr do
  subject { described_class.new }

  describe "#lookup" do
    it do
      results = subject.lookup("195.123.228.14")
      expect(results).to be_an(Array)
    end

    it do
      results = subject.lookup("cunkt.club")
      expect(results).to be_an(Array)
    end
  end
end
