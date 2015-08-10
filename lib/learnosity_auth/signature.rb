require "digest"

module LearnosityAuth
  class Signature
    def initialize(consumer_key:, consumer_secret:, domain:, user_id:, timestamp:)
      @consumer_key    = consumer_key
      @consumer_secret = consumer_secret
      @domain          = domain
      @user_id         = user_id
      @timestamp       = timestamp
    end

    def generate
      Digest::SHA256.hexdigest(prehash_string)
    end

    private
    
    def prehash_string
      [@consumer_key, @domain, @timestamp, @user_id, @consumer_secret].join("_")
    end
  end
end
