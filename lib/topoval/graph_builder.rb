module Topoval
  class GraphBuilder
    def initialize
      @graph = RGL::DirectedAdjacencyGraph.new
    end

    def add_method(method_name, existing_method_names)
      @graph.add_vertex(method_name)

      existing_method_names.each do |existing_name|
        @graph.add_edge(existing_name, method_name)
      end
    end

    def graph
      @graph
    end
  end
end
