# LearnosityAuth

A gem that handles authorization for Learnosity. See http://docs.learnosity.com/authoring/author/security

## Usage

### Generating a Signature

In order to use several of Learnosity's APIs, you will need to generate a signature. A signature is a 64-char hashed string from the following 5 items:

* Consumer Key
     * Supplied by Learnosity. Needs to match [the consumer_key param](http://docs.learnosity.com/assessment/questions/initialisation#consumer_key) you will use to initialize the Learnosity App.
* Consumer Secret
     * Supplied by Learnosity, known only by the client and Learnosity
* Domain
     * Needs to match *location.host*. Learnosity will check this against a list of authorized domains
* User ID
     * Needs to match [the user_id param](http://docs.learnosity.com/assessment/questions/initialisation#user_id) you will use to initialize the Learnosity App.
* Timestamp
     * Needs to be formatted "{year}{month}{day}-{hour}{minute}"
     * Needs to match [the timestamp param](http://docs.learnosity.com/assessment/questions/initialisation#timestamp) you will use to initialize Learnosity App
     * In ruby: `Time.now.strftime("%Y%m%d-%H%M")`  


```
#!ruby
require 'LearnosityAuth'

# to create a signature you need five items: consumer_key, consumer_secret, your domain, the user_id, and a timestamp
credentials = {
  consumer_key: "c0n$um3r_key",
  consumer_secret: "s3cr3t_s3cr3t",
  domain: "your_domain",
  user_id: "123456",
  timestamp: "20150919-1245"
}

# Create a new Signature with the required items and call the generate method. 
signature = LearnosityAuth::Signature.new(credentials).generate
# => "26d0d45afac76a805bb1efe0f8ad1feb8572d4a03781ea1aea2f0531cb35a5b4"

```


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'learnosity_auth'
```

And then execute:

    $ bundle