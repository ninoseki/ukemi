# frozen_string_literal: true

RSpec.describe Ukemi::CLI do
  subject { described_class }

  let(:pt_mock) { double("PassiveTotal") }
  let(:vt_mock) { double("VirusTotal") }
  let(:st_mock) { double("SecurityTrails") }
  let(:circl_mock) { double("CIRCL") }

  before do
    allow(Ukemi::Moderator).to receive(:lookup).and_return({})
  end

  describe "#lookup" do
    it do
      expect { subject.start(%w(lookup 1.1.1.1)) }.to output.to_stdout
    end
  end

  describe "#refang" do
    subject { described_class.new }

    it do
      expect(subject.refang("1.1.1.1")).to eq("1.1.1.1")
    end

    it do
      expect(subject.refang("1.1.1[.]1")).to eq("1.1.1.1")
    end

    it do
      expect(subject.refang("1.1.1(.)1")).to eq("1.1.1.1")
    end
  end
end
