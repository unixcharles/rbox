module Rbox
  module Authentication

    def get_ticket
      response = action(:get_ticket)
      Response::Ticket.new(response, self)
    end

    def get_auth_token
      raise 'Ticket is require for this operation' unless ticket

      response = action(:get_auth_token) do |req|
        req.params[:ticket] = ticket        
      end
      Response::AuthToken.new(response, self)
    end

    def logout
      response = action(:logout)
      Response::Logout.new(response, self)
    end

    def register_new_user(login, password)
      response = action(:register_new_user)
      Response::RegisterNewUser.new(response, self)
    end

    def verify_registration_email
      response = action(:verify_registration_email)
      Response::VerifyRegistrationEmail.new(response, self)
    end

    def get_account_info
      response = action(:get_account_info)
      Response::GetAccountInfo.new(response, self)
    end

    def authorize_url
      "https://www.box.net/api/1.0/auth/#{@ticket}"
    end

  end
end