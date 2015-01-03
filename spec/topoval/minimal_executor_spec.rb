require "spec_helper"

describe Topoval::MinimalExecutor do
  describe "execute!" do
    it "executes the methods specified until one returns false" do
      spy = Spy.new

      graph_builder = Topoval::GraphBuilder.new
      graph_builder.add_method("returns_true", [])
      graph_builder.add_method("returns_false", ["returns_true"])
      graph_builder.add_method("raises_error", ["returns_false"])

      executor = Topoval::MinimalExecutor.new(spy, graph_builder.graph)
      executor.execute!

      expect( spy.calls("returns_true") ).to eq 1
      expect( spy.calls("returns_false") ).to eq 1
      expect( spy.calls("raises_error") ).to eq 0
    end

    it "executes all the methods in the graph if possible" do
      spy = Spy.new

      graph_builder = Topoval::GraphBuilder.new
      graph_builder.add_method("returns_true", [])
      graph_builder.add_method("returns_true_2", ["returns_true"])
      graph_builder.add_method("returns_true_3", ["returns_true"])

      executor = Topoval::MinimalExecutor.new(spy, graph_builder.graph)
      executor.execute!

      expect( spy.calls("returns_true") ).to eq 1
      expect( spy.calls("returns_true_2") ).to eq 1
      expect( spy.calls("returns_true_3") ).to eq 1
    end

    it "stops invoking methods after the first failure" do
      spy = Spy.new

      graph_builder = Topoval::GraphBuilder.new
      graph_builder.add_method("returns_true", [])
      graph_builder.add_method("returns_true_2", ["returns_true"])
      graph_builder.add_method("returns_false", [])

      executor = Topoval::MinimalExecutor.new(spy, graph_builder.graph)
      executor.execute!

      expect( spy.calls("returns_false") ).to eq 1
      expect( spy.calls("returns_true") ).to eq 0
      expect( spy.calls("returns_true_2") ).to eq 0
    end
  end
end
