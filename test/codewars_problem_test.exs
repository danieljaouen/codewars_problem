defmodule CodewarsProblemTest do
  use ExUnit.Case
  doctest CodewarsProblem

  describe "solution" do
    test "returns the correct value" do
      assert CodewarsProblem.solution(["A", "A", "A", "B", "B", "C", "A", "A", "D", "E", "E", "E", "E"]) == ["A", "B", "C", "A", "D", "E"]
      assert CodewarsProblem.solution("AAABBCAADEEEE") == ["A", "B", "C", "A", "D", "E"]
      assert CodewarsProblem.solution_without_ets(["A", "A", "A", "B", "B", "C", "A", "A", "D", "E", "E", "E", "E"]) == ["A", "B", "C", "A", "D", "E"]
      assert CodewarsProblem.solution_without_ets("AAABBCAADEEEE") == ["A", "B", "C", "A", "D", "E"]
    end
  end
end
