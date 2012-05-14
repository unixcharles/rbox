module Rbox
  module CollectNestedKey

    def collect_nested_key(obj, key)
      result = []

      case obj
      when Hash
        if obj.key? key
          result << obj[key]
        else
          obj.each do |k, child|
            result += collect_nested_key(child, key)
          end
        end
      when Array
        obj.each do |child|
          result += collect_nested_key(child, key)
        end
      end

      result.flatten
    end

  end
end