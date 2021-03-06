require 'json'

module Reloader
  class SSE
    def initialize io
      @io = io
    end

    def write object, options = {}
      options.each do |key,value|
        @io.write "#{key}: #{value}\n"
      end
      @io.write "data: #{JSON.dump(object)}\n\n"
    end

    def close
      @io.close
    end
  end
end
