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

  test "Given the score is Fifteen - Love When player get score Then judge should announce Fifteen - All" do
    score_card = Score.game_start
    score_card = set_score_to_server(score_card, 1)

    score_card = Score.to_player score_card

    assert "Fifteen - All" == score_card |> TennisRule.get_player_score |> TennisRule.announce
  end

  test "Given the score is Fifteen - All When sever get score Then judge should announce Thirty - Fifteen" do
    score_card = Score.game_start
    score_card = set_score_to_server(score_card, 1)
    score_card = set_score_to_player(score_card, 1)

    score_card = Score.to_server score_card

    assert "Thirty - Fifteen" == score_card |> TennisRule.get_player_score |> TennisRule.announce
  end

  test "Given the score is Thirty - Fifteen When player get score Then judge should announce Thirty - All" do
    score_card = Score.game_start
    score_card = set_score_to_server(score_card, 2)
    score_card = set_score_to_player(score_card, 1)

    score_card = Score.to_player score_card

    assert "Thirty - All" == score_card |> TennisRule.get_player_score |> TennisRule.announce
  end

  test "Given the score is Thirty - All When server get score Then judge should announce Forty - Thirty" do
    score_card = Score.game_start
    score_card = set_score_to_server(score_card, 2)
    score_card = set_score_to_player(score_card, 2)

    score_card = Score.to_server score_card

    assert "Forty - Thirty" == score_card |> TennisRule.get_player_score |> TennisRule.announce
  end

  test "Given the score is Forty-Thirty and the player get score Then judge should announce Deuce" do
    score_card = %{player: {}, server: {}}
    score_card = set_score_to_server(score_card, 3)
    score_card = set_score_to_player(score_card, 2)

    score_card = Score.to_player score_card

    assert "Deuce" == score_card |> TennisRule.get_player_score |> TennisRule.announce
  end

  test "Given the score is Deuce and the server get score Then judge should announce Advantage to Server" do
    score_card = %{player: {}, server: {}}
    score_card = set_score_to_server(score_card, 3)
    score_card = set_score_to_player(score_card, 3)

    score_card = Score.to_server score_card

    assert "Advantage to Server" == score_card |> TennisRule.get_player_score |> TennisRule.announce
  end    
  
  test "Given the score is Advantage to Server and the player get score Then judge should announce Deuce" do
    score_card = %{player: {}, server: {}}
    score_card = set_score_to_server(score_card, 4)
    score_card = set_score_to_player(score_card, 3)

    score_card = Score.to_player score_card

    assert "Deuce" == score_card |> TennisRule.get_player_score |> TennisRule.announce
  end


  test "Given the score is Advantage to Server and the server get score Then judge should announce Game Set Server Win" do
    score_card = %{player: {}, server: {}}
    score_card = set_score_to_server(score_card, 4)
    score_card = set_score_to_player(score_card, 3)

    score_card = Score.to_server score_card

    assert "Game Set Server Win" == score_card |> TennisRule.get_player_score |> TennisRule.announce
  end  

  test "Given the score is Deuce and the player get score Then judge should announce Advantage to Player" do
    score_card = %{player: {}, server: {}}
    score_card = set_score_to_server(score_card, 3)
    score_card = set_score_to_player(score_card, 3)

    score_card = Score.to_player score_card

    assert "Advantage to Player" == score_card |> TennisRule.get_player_score |> TennisRule.announce
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
