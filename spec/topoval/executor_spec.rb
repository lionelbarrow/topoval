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
  end
end
