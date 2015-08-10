require 'spec_helper'

describe LearnosityAuth::Signature do
  let(:consumer_key)    { "1234abcde" }
  let(:consumer_secret) { "secretsecret" }
  let(:domain)          { "masteryconnect.com" }
  let(:user_id)         { "123456" }
  let(:timestamp)       { Time.now.strftime("%Y%m%d-%H%M") }
  let(:signature) { 
    LearnosityAuth::Signature.new(
      consumer_key: consumer_key, 
      consumer_secret: consumer_secret,
      domain: domain,
      user_id: user_id,
      timestamp: timestamp)
  }

  it 'generates a 64-char signature' do
    expect(signature.generate.length).to eq(64)
  end

  it "has been hashed by SHA-256 with correct parameters" do
    expect(Digest::SHA256).to receive(:hexdigest).with("#{consumer_key}_#{domain}_#{timestamp}_#{user_id}_#{consumer_secret}")
    signature.generate
  end

  context "when missing required arguments" do

    it "throws error" do
      expect{LearnosityAuth::Signature.new}.to raise_error(ArgumentError)
    end
  end
end