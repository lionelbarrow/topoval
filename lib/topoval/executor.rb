module Topoval
  class Executor
    def initialize(target)
      @target = target
      @graph = RGL::DirectedAdjacencyGraph.new
    end

    def add_method(method_name, existing_method_names)
      name = method_name.to_sym
      existing_names = existing_method_names.map(&:to_sym)

      @graph.add_vertex(name)

      existing_names.each do |existing_name|
        @graph.add_edge(existing_name, name)
      end
    end

    def execute!
      iterator = RGL::TopsortIterator.new(@graph)
      until iterator.at_end? do
        method = iterator.basic_forward
        return unless @target.send(method)
      end
    end
  end
end
