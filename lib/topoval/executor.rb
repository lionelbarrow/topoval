module Topoval
  class Executor
    def initialize(target)
      @target = target
      @graph = RGL::DirectedAdjacencyGraph.new
    end

    def add_method(method_name, existing_method_names)
      @graph.add_vertex(method_name)

      existing_method_names.each do |existing_name|
        @graph.add_edge(existing_name, method_name)
      end
    end

    def execute!
      raise "Circular dependency detected" unless @graph.acyclic?

      iterator = RGL::TopsortIterator.new(@graph)
      until iterator.at_end? do
        method = iterator.basic_forward
        return unless @target.send(method)
      end
    end
  end
end
