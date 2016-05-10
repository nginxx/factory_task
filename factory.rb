# Dynamic class creator factory
class Factory
  def self.new(*attrs, &block)
    Class.new do
      attr_accessor(*attrs)
      define_method(:initialize) do |*vals|
        if vals.size != attrs.size
          text = "Wrong number of arguments.
                 #{vals.size} given, instead of #{attrs.size}"
          raise(ArgumentError, text)
        end
        attrs.each_with_index do |val, key|
          instance_variable_set("@#{val}", vals[key])
        end
      end
    end
  end
end
Klass = Factory.new(:name, :surname)
obj = Klass.new('ivan', 'petrov')
puts obj.surname
