require 'rspec'
require_relative '../factory'

RSpec.describe 'Factory behaviour.' do
  Klass = Factory.new(:name, :surname)
  context 'Check attributes creation.' do
    it 'Should return proper attributes values' do
      obj = Klass.new('ivan', 'petrov')
      expect(obj.name).to eq('ivan')
      expect(obj.surname).to eq('petrov')
    end
  end

  context 'Check attributes quantity.' do
    it 'Should throw ArgumentException if quantity differs.' do
      expect { Klass.new('ivan') }.to raise_error(ArgumentError)
    end

  end

  context 'Check method creation.' do
    it 'Should create proper method.' do
      Klass = Factory.new(:name) do
        def my_meth
          'hello'
        end
        def my_meth_2
          'bye'
        end
        def my_meth_3
          @name
        end
        def my_meth_4(arg)
          arg
        end
      end
      expect(Klass.allocate.my_meth).to eq('hello')
      expect(Klass.allocate.my_meth_2).to eq('bye')
      expect(Klass.new('vasya').my_meth_3).to eq('vasya')
      expect(Klass.allocate.my_meth_4('some_arg')).to eq('some_arg')
    end
  end
end
