module Rbox
  module Response
    module Base
      def initialize(response, client)
        @response = response
        @body_response = response.body['response']
        @client = client
        raise "Response failure with status code \"#{status}\"" unless success?
      end

      def success?
        !!(status =~ /_ok\z/)
      end

      def status
        @body_response['status']
      end

      def method_missing(name, *args, &block)
        @client.send(name, *args, &block)
      end
    end
  end
end