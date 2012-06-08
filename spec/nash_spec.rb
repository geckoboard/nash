require 'spec_helper'

describe Hashie::Nash do
  
  class Test1 < Hashie::Nash
    property :meh,:required => true
  end
  
  class NestedTest < Hashie::Nash
    property :nest, :class => Test1 
  end
  
  it "should create a new Test1" do
     t = Test1.new "meh"=> 5
     t.nil?.should == false
  end
  
  it "should create a new NestedTest" do
     t = NestedTest.new "nest" => {"meh"=> 5}
     t.nil?.should == false
  end
  
  it "should make nested hashes accessible" do
    t = NestedTest.new "nest" => {"meh"=> 5}
    t.nest.meh.should == 5
  end
  
  it "should make validate required properties in nested dash" do
    lambda do
    t = NestedTest.new "nest" => {"non_existent"=> 5}
    t.nest.meh.should == 5
    end.should raise_error NoMethodError
  end

  class Car < Hashie::Nash
    class Engine < Hashie::Nash
      property :crankshaft, :required => true
      property :nitro, :default => false
    end
    property :engine, :required => true, :class => Engine 
  end


  it "should make validate required properties in nested dash" do
    c = Car.new "engine" => {"crankshaft" => true, "nitro" => false}
    c.engine.crankshaft.should == true
  end

end
