module Rbox
  module Response
    class Ticket
      include Base

      def initialize(*arg)
        super(*arg)
        @client.ticket = ticket
      end

      def ticket
        @body_response['ticket']
      end

      def authentization_url
        "https://www.box.net/api/1.0/auth/#{ticket}"
      end

      def auth_token
        @client.auth_token(ticket)
      end

      def attributes
        { :ticket => @body_response['ticket'] }
      end

    end
  end
end