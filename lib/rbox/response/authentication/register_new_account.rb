module Rbox
  module Response
    class RegisterNewAccount
      include Base

      def initialize(*arg)
        super(*arg)
        @client.auth_token = auth_token
      end

      def auth_token
        @body_response['auth_token']
      end

      def user
        @body_response['user']
      end

      def attributes
        { :user => user, :auth_token => auth_token }
      end

      def success?
        !!(status == 'successful_register')
      end

    end
  end
end