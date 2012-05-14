require File.expand_path('../spec_helper', __FILE__)

describe Rbox::Client do

  before do
    @options = { :api_token => 'unique-api-token', :auth_token => 'unique-auth-token' }
    @client = Rbox.new(@options)
  end

  it "get ticket and generate authorize_url" do
    VCR.use_cassette('tickets') do
      @client.get_ticket
      @client.authorize_url
    end
  end

  it "get ticket and generate authorize_url" do
    VCR.use_cassette('tickets') { @client.get_ticket }
    assert_equal @client.authorize_url, 'https://www.box.net/api/1.0/auth/unique-secret-ticket'
  end

  it "get account informations" do
    VCR.use_cassette('account_info') { @account_info = @client.get_account_info }
    assert_kind_of Rbox::Response::GetAccountInfo, @account_info
    user_info = { "login"=>"unixcharles@gmail.com", "email"=>"unixcharles@gmail.com", "access_id"=>"176951347", "user_id"=>"176951347", "space_amount"=>"5368709120", "space_used"=>"12205491", "max_upload_size"=>"104857600"}
    assert_equal @account_info.user, user_info
  end

  it "get the account tree" do
    VCR.use_cassette('account_tree') { @account_tree = @client.get_account_tree }
    assert_kind_of Rbox::Response::AccountTree, @account_tree
    assert_kind_of  Rbox::Response::Folder, @account_tree.root_folder
  end

  it "get the file by id" do
    VCR.use_cassette('file_info') { @file = @client.get_file_info(2104480929) }
    assert_kind_of Rbox::Response::File, @file
    assert_equal @file.file_name, 'IMG_0174.jpg'
  end

  it "enable public sharing on a file" do
    VCR.use_cassette('public_share') do
      @file = @client.get_file_info(2104480929)
      assert_equal @file.public_share_url, 'https://www.box.net/s/b001ec95feb815091d70'
    end
  end
end