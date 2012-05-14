module Rbox
  module Response
    class GetAccountInfo
      include Base

      def user
        @body_response['user']
      end

      def attributes
        { :user => user }
      end

    end
  end
end