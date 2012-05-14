module Rbox
  class Client
    include Connection
    include Authentication
    include Download
    include Item

    attr_accessor :config, :api_token, :auth_token, :ticket
    attr_reader :connection

    def initialize(options = {})
      @config = options
      @api_token = @config[:api_token]
      @auth_token = @config[:auth_token]
      @ticket = @config[:ticket]
      @connection = default_connection
    end

  end
end