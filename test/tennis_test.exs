defmodule TennisTest do
  use ExUnit.Case
  doctest TennisRule
  test "game start" do
    assert "Fifteen - All" TennisRule.count({1, 1})
  end
end
