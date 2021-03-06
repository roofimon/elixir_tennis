defmodule TennisRule do

  def get_player_score(score_card) do
    score_card |> Enum.map(fn({k, v}) -> {k, tuple_size(v)} end) |> Enum.into(%{})
  end

  def announce(score) do
    score_mapping = {"Love", "Fifteen", "Thirty", "Forty"}
    {server, player} = {score.server, score.player}
    case {server, player} do
      {0, 0} -> "Start Game!"
      {0, y} when y <= 3 -> "Love - "<> elem(score_mapping, y)
      {x, 0} when x <= 3 -> elem(score_mapping, x)<>" - Love"
      {x, y} when x == y and x < 3 and y < 3 -> elem(score_mapping, x)<>" - All"
      {x, y} when x <= 3 and y <= 3 and x + y < 6 -> elem(score_mapping, x)<>" - "<>elem(score_mapping, y)
      {x, y} when x ==y and y >=3 -> "Deuce"
      {x, y} when x >= 3 and x-y == 1 -> "Advantage to Server"
      {x, y} when x >= 3 and y-x == 1 -> "Advantage to Player"
      {x, 4} when x <= 2 -> "Game Set Player Win"
      {4, x} when x <= 2 -> "Game Set Server Win"
      {x, y} when x > 3 and x-y == 2 -> "Game Set Server Win"
      {x, y} when y > 3 and x-x == 2 -> "Game Set Player Win"
      _ -> score
    end
  end

end
