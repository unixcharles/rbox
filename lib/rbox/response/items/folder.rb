module Rbox
  module Response
    class Folder

      ATTRIBUTES = %w(id name description user_id shared shared_link permissions size file_count tags)

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

        @folders_attr = [@attributes['folders']['folder']].flatten rescue []
        @attributes.delete('folders')

        # lol, { files => { file => [file, ...] } }
        @files_attr = [@attributes['files']['file']].flatten  rescue []
        @attributes.delete('files')
      end

      def folders
        @folders ||= @folders_attr.map {|f| Folder.new(f, @client, self) }
      end

      def create_folder(name, options = {})
        options[:parent_id] = id
        @client.create_folder(name, options)
      end

      def files
        @files ||= @files_attr.map {|f| File.new(f, @client, self) }
      end

      def attributes
        @attributes
      end

      def root?
        id == '0'
      end

      def to_hash
        hash = ATTRIBUTES.inject({}) {|h,k,v| h[k.to_sym]= @attributes[k]; h }
        hash[:files]   = files.map {|f| f.to_hash }
        hash[:folders] = folders.map {|f| f.to_hash }
        hash[:type] = 'folder'
        hash[:parent_folder_id] = @parent_folder.id if @parent_folder
        hash
      end
    end
  end
end