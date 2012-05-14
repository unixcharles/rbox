module Rbox
  module Response
    class AccountTree
      include Base
      include CollectNestedKey

      def root_folder
        @root_folder ||= Folder.new(@body_response['tree']['folder'], @client)
      end
      alias :tree :root_folder

      def files
        @files ||= collect_nested_key(@body_response['tree'], 'file').map {|f| File.new(f, @client) }
      end

      def folders
        @folder ||= collect_nested_key(@body_response['tree'], 'folder').map {|f| Folder.new(f, @client) }
      end

      def to_array
        root_folder.folders.map {|f| f.to_hash } + root_folder.files.map {|f| f.to_hash }
      end
      alias :to_a :to_array

      def to_hash
        root_folder.to_hash
      end
      alias :to_h :to_hash
      alias :attributes :to_hash

    end
  end
end