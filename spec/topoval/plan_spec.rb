require "spec_helper"

describe Topoval::Plan do
  describe "add_step" do
    it "adds a method and its dependencies"

    it "is not order dependent"
  end

  describe "execute!" do
    it "uses a maximal executor by default" do
      spy = Spy.new

      plan = Topoval::Plan.new(spy)
      plan.add_step("returns_true", [])
      plan.add_step("returns_true_2", ["returns_true"])
      plan.add_step("returns_false", [])
      plan.add_step("raises_error", ["returns_false"])

      plan.execute!

      expect( spy.calls("returns_false") ).to eq 1
      expect( spy.calls("raises_error") ).to eq 0
      expect( spy.calls("returns_true") ).to eq 1
      expect( spy.calls("returns_true_2") ).to eq 1
    end

    it "uses a maximal executor if the option is passed" do
      spy = Spy.new

      plan = Topoval::Plan.new(spy)
      plan.add_step("returns_true", [])
      plan.add_step("returns_true_2", ["returns_true"])
      plan.add_step("returns_false", [])
      plan.add_step("raises_error", ["returns_false"])

      plan.execute!(:strategy => Topoval::Strategy::Maximal)

      expect( spy.calls("returns_false") ).to eq 1
      expect( spy.calls("raises_error") ).to eq 0
      expect( spy.calls("returns_true") ).to eq 1
      expect( spy.calls("returns_true_2") ).to eq 1
    end

    it "uses a minimal executor if the option is passed" do
      spy = Spy.new

      plan = Topoval::Plan.new(spy)
      plan.add_step("returns_true", [])
      plan.add_step("returns_true_2", ["returns_true"])
      plan.add_step("returns_false", [])
      plan.add_step("raises_error", ["returns_false"])

      plan.execute!(:strategy => Topoval::Strategy::Minimal)

      expect( spy.calls("returns_false") ).to eq 1
      expect( spy.calls("raises_error") ).to eq 0
      expect( spy.calls("returns_true") ).to eq 0
      expect( spy.calls("returns_true_2") ).to eq 0
    end
  end
end
