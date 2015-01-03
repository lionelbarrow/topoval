require "spec_helper"

describe Topoval::Executor do
  describe "execute!" do
    it "executes the methods specified until one returns false" do
      spy = Spy.new

      executor = Topoval::Executor.new(spy)
      executor.add_method("returns_true", [])
      executor.add_method("returns_false", ["returns_true"])
      executor.add_method("raises_error", ["returns_false"])

      executor.execute!

      expect( spy.calls("returns_true") ).to eq 1
      expect( spy.calls("returns_false") ).to eq 1
      expect( spy.calls("raises_error") ).to eq 0
    end

    it "executes all the methods in the graph if possible" do
      spy = Spy.new

      executor = Topoval::Executor.new(spy)
      executor.add_method("returns_true", [])
      executor.add_method("returns_true_2", ["returns_true"])
      executor.add_method("returns_true_3", ["returns_true_2"])

      executor.execute!

      expect( spy.calls("returns_true") ).to eq 1
      expect( spy.calls("returns_true_2") ).to eq 1
      expect( spy.calls("returns_true_3") ).to eq 1
    end

    it "raises an error if the graph has circular dependencies" do
      executor = Topoval::Executor.new(nil)
      executor.add_method("a", ["b"])
      executor.add_method("b", ["a"])

      expect do
        executor.execute!
      end.to raise_error
    end
  end
end
