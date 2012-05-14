require 'faraday'
require 'faraday_middleware'

module Rbox
  module Connection

  private
    def action(action, options = {}, &block)
      params = { :action => action.to_s }
      params[:api_key] = api_token if api_token
      params[:auth_token] = auth_token if auth_token
      connection.get('/api/1.0/rest') do |req|
        req.params = req.params.merge(params)
        block.call(req) if block_given?
      end
    end

    def default_connection
      Faraday.new(:url => 'https://www.box.net/') do |builder|
        builder.use Faraday::Response::ParseXml
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Response::Logger if @config[:logger]
        builder.use Faraday::Adapter::NetHttp
      end
    end

    def set_connection(*arg, &block)
      @connection = Faraday.send(:new, *args, &block)
    end
  end
end