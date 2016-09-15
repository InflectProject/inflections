require 'wit'

class WitService < Inflect::AbstractService
  attr_accessor :client  

  def initialize
    @priority = 1
    @words    = %W[WIT MESSAGE].freeze

    actions = {
      send: -> (request, response) {
        puts("sending... #{response['text']}")
      },
      my_action: -> (request) {
        return request['context']
      },
    }

    @access_token = 'VJGR5JNOYQLL7LZXWBSU2UQNFU7C3F3V'
    @client = Wit.new(access_token: @access_token, actions: actions)
  end

  # This method is the only one needed for Inflect to work.
  # Implements how the service responds to a request that has no
  # action attribute.
  # @return Inflect::Response
  def message(message)
    respond client.message(message)
  end
end
