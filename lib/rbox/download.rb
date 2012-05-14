module Rbox
  module Download

    def download_url(file_id)
      "https://www.box.net/api/1.0/download/#{auth_token}/#{file_id}"
    end

  end
end