defmodule TennisRuleTest do
  use ExUnit.Case
  doctest TennisRule
  test "Game Start when both player has no score" do
    score_card = %{player: {}, server: {}}
    assert "Start Game!"  == score_card |> TennisRule.get_player_score |> TennisRule.announce
  end

  test "Given game start When server get first score Then judge should announce Fifteen - Love" do
    score_card = %{player: {}, server: {}}
    score_card = Score.to_server score_card
    assert "Fifteen - Love" == score_card |> TennisRule.get_player_score |> TennisRule.announce
  end

  test "Given the score is Forty-Thirty and the player get score Then judge should announce Deuce" do
    score_card = %{player: {}, server: {}}
    score_card = set_score_to_server(score_card, 3)
    score_card = set_score_to_player(score_card, 2)

    score_card = Score.to_player score_card

    assert "Deuce" == score_card |> TennisRule.get_player_score |> TennisRule.announce
  end

  def set_score_to_server(score_card, n) when n <=1 do
    Score.to_server score_card
  end

  def set_score_to_server(score_card, n) do
    score_card = Score.to_server score_card
    set_score_to_server(score_card, n-1)
  end

  def set_score_to_player(score_card, n) when n <=1 do
    Score.to_player score_card
  end

  def set_score_to_player(score_card, n) do
    score_card = Score.to_player score_card
    set_score_to_player(score_card, n-1)
  end
end
