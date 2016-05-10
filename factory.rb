# Dynamic class creator factory
class Factory
  def self.new(*attrs, &block)
    klass = Class.new do
      attr_accessor(*attrs)
      define_method(:initialize) do |*vals|
        if vals.size != attrs.size
          text = "Wrong number of arguments,
                 given #{vals.size}, expected #{attrs.size}"
          raise(ArgumentError, text)
        end
        attrs.each_with_index do |val, key|
          instance_variable_set("@#{val}", vals[key])
        end
      end
    end

    klass.class_eval(&block) if block_given?
    klass
  end
end
