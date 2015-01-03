require "./lib/topoval"

class Spy
  def initialize
    @calls = Hash.new(0)
  end

  def calls(method_name)
    @calls[method_name]
  end

  def returns_true
    @calls["returns_true"] += 1
    true
  end

  def returns_false
    @calls["returns_false"] += 1
    false
  end

  def raises_error
    @calls["raises_error"] += 1
    raise "Uh oh!"
  end
end
