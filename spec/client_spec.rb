require "spec_helper"

describe RestfulKashflow::Client do
  subject { -> { described_class.new(options) } }

  let(:options) do
    {
      environment: environment,
      username: username,
      password: password,
      memorable_word: memorable_word,
    }
  end

  context "when initialised without a username" do
    let(:environment) { :live }
    let(:username) { nil }
    let(:password) { "password" }
    let(:memorable_word) { "sausages" }

    it { is_expected.to raise_error("No username given to Restful Kashflow Client") }
  end

  context "when initialised without a password" do
    let(:environment) { :live }
    let(:username) { "username" }
    let(:password) { nil }
    let(:memorable_word) { "sausages" }

    it { is_expected.to raise_error("No password given to Restful Kashflow Client") }
  end

  context "when initialised without a username" do
    let(:environment) { :live }
    let(:username) { "username" }
    let(:password) { "password" }
    let(:memorable_word) { nil }

    it { is_expected.to raise_error("No memorable word given to Restful Kashflow Client") }
  end
end
