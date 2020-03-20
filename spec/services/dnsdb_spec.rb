# frozen_string_literal: true

RSpec.describe Ukemi::Services::DNSDB, :vcr do
  subject { described_class.new }

  describe "#lookup" do
    it do
      results = subject.lookup("149.13.33.14")
      expect(results).to be_an(Array)
    end

    it do
      results = subject.lookup("circl.lu")
      expect(results).to be_an(Array)
    end
  end
end
