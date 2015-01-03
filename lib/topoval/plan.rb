module Topoval
  class Plan
    def initialize(target)
      @target = target
      @graph_builder = GraphBuilder.new
    end

    def add_step(method_name, dependencies)
      @graph_builder.add_method(method_name, dependencies)
    end

    def execute!(options = {})
      _executor({:strategy => Strategy::Maximal}.merge(options)).execute!
    end

    def _executor(options)
      graph = @graph_builder.graph

      case options[:strategy]
      when Strategy::Maximal then MaximalExecutor.new(@target, graph)
      when Strategy::Minimal then MinimalExecutor.new(@target, graph)
      else raise "Unknown execution strategy #{options[:strategy]}"
      end
    end
  end
end
