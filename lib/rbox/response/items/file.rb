module Rbox
  module Response
    class File

      ATTRIBUTES = %w(id file_name shared sha1 size shared_link description user_id thumbnail small_thumbnail large_thumbnail larger_thumbnail preview_thumbnail permissions tags)

      ATTRIBUTES.each do |attr_name|
        define_method(attr_name) do
          instance_variable_get(:@attributes)[attr_name]
        end
      end

      %w(created updated).each do |attr_name|
        define_method(attr_name) do
          Time.at(instance_variable_get(:@attributes)[attr_name])
        end
      end

      def initialize(attributes, client, parent_folder = nil)
        @attributes = attributes.dup
        @client = client
        @parent_folder = parent_folder
      end

      def attributes
        @attributes
      end

      def download_url
        @client.download_url(id)
      end

      # public share
      # https://www.box.net/api/1.0/rest?action=public_share&api_key=rrc1d3ntb53tt6b2vhail6rdtrsxov3v&auth_token=rpuis3lincpbyz60gyym8s3xhnc6gbcl&target=folder&target_id=709&password=&message=hey&emails[]=email@example.com&emails[]=email2@example.com
      def public_share!
        @public_name ||= @client.public_share(self.id, 'file')
        true
      end

      def public_share_url
        if @public_link.nil? || @public_link.empty?
          public_share!
          "https://www.box.net/s/#{@public_name}"
        else
          @public_link
        end
      end

      def to_hash
        hash = ATTRIBUTES.inject({}) {|h,k,v| h[k.to_sym]= @attributes[k]; h }
        hash[:type] = 'file'
        hash[:parent_folder_id] = @parent_folder.id if @parent_folder
        hash
      end
    end
  end
end