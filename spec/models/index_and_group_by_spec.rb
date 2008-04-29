require 'active_support'
require File.dirname(__FILE__) + "/../../config/initializers/index_and_group_by"

describe Enumerable, ".index_and_group_by" do
  before(:each) do
    @numeros = 0..10
  end

  it "deve agrupar pelo indice a propriedade especificada" do
    pares = @numeros.index_and_group_by do |e|
      [e.even?, e * 10]
    end
    pares.should have(2).items
    pares.keys.should == [true, false]
    pares[true].should have(6).items
    pares[false].should have(5).items
    pares[false].should == [10, 30, 50, 70, 90]
    pares[true].should == [0, 20, 40, 60, 80, 100]
  end
end
