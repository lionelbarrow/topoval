module Topoval
  class MinimalExecutor
    def initialize(target, graph)
      @target = target
      @graph = graph
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
