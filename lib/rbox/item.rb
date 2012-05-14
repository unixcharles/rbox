module Rbox
  module Item

    def get_account_tree(options = { :folder_id => 0 })
      raise 'Auth token and api key is require for this operation' unless auth_token and api_token

      response = action(:get_account_tree) do |req|
        req.params['params[]'] = 'nozip'
        req.params.merge!(options)
      end
      Response::AccountTree.new(response, self)
    end
 
    def get_file_info(file_id, options = {} )
      raise 'Auth token and api key is require for this operation' unless auth_token and api_token

      response = action(:get_file_info) do |req|
        req.params.merge!(options)
        req.params[:file_id] = file_id
      end

      response_file = response.body['response']['info']
      response_file['id'] = response_file['file_id']

      Response::File.new(response_file, self)
    end

    def public_share(target_id, target_type = 'file')
      response = action(:public_share) do |req|
        req.params[:target] = target_type
        req.params[:target_id] = target_id

        # Yes, we need those empty strings
        %w(password message emails[]).each do |key|
          req.params[key] = ''
        end
      end

      response.body['response']['public_name']
    end

  end
end