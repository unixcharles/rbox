# Client modules
require 'rbox/connection'
require 'rbox/authentication'
require 'rbox/download'
require 'rbox/item'
# Client class
require 'rbox/client'
require 'rbox/errors'

# Utility methods modules
require 'rbox/utils/collect_nested_key'

# Base response module
require 'rbox/response/base'
# Authentication response classes
require 'rbox/response/authentication/ticket'
require 'rbox/response/authentication/get_account_info'
require 'rbox/response/authentication/verify_registration_email'
require 'rbox/response/authentication/auth_token'
require 'rbox/response/authentication/logout'
require 'rbox/response/authentication/register_new_account'
# Items response classes
require 'rbox/response/items/account_tree'
require 'rbox/response/items/folder'
require 'rbox/response/items/file'


module Rbox
  class << self
    def new(*arg)
      Rbox::Client.new(*arg)
    end
  end
end