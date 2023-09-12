# frozen_string_literal: true

RSpec.describe RequiredEnvFetcher do
  describe ".fetch" do
    let(:key) { "INTERESTING_THING" }

    context "when the key we're fetching is set in the environment" do
      subject { described_class.fetch(key) }

      let(:value) { "some value" }

      around do |example|
        ClimateControl.modify(key => value) do
          example.run
        end
      end

      it { is_expected.to eq value }
    end

    context "when the key we're fetching is not set in the environment" do
      context "and we're allowing required environment variables to get default values" do
        around do |example|
          ClimateControl.modify(SKIP_REQUIRED_ENV_VAR_ENFORCEMENT: "true") do
            example.run
          end
        end

        context "and there's a default supplied" do
          subject { described_class.fetch("SETTING", default) }

          let(:default) { "some default" }

          it { is_expected.to eq default }
        end

        context "and there's no default supplied" do
          subject { described_class.fetch("SETTING") }

          it { is_expected.to eq "" }
        end
      end

      context "and we're not allowing required environment variables to get default values" do
        it "raises an error" do
          expect do
            described_class.fetch("SETTING", "a default")
          end.to raise_error(KeyError)
        end
      end
    end
  end
end
