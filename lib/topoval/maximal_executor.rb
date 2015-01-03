module Topoval
  class MaximalExecutor
    def initialize(target, graph)
      @target = target
      @graph = graph
    end

    def execute!
      iterator = RGL::TopsortIterator.new(@graph)
      completed_methods = []
      while !iterator.at_end? do
        method = iterator.basic_forward
        success = @target.send(method)

        if !success
          _remove_completed_and_failed_methods(method, completed_methods)
          return execute!
        end

        completed_methods << method
      end
    end

    def _remove_completed_and_failed_methods(failed_method, completed_methods)
      _remove_methods(completed_methods)

      unreachable_methods = []
      iterator = RGL::BFSIterator.new(@graph, failed_method)
      while !iterator.at_end? do
        unreachable_methods << iterator.basic_forward
      end

      _remove_methods(unreachable_methods)
    end

    def _remove_methods(methods)
      methods.each do |method_name|
        @graph.remove_vertex(method_name)
      end
    end
  end
end
