defmodule TennisRule do

  def get_player_score(score) do
    score |> Enum.map(fn({_, v}) -> tuple_size(v) end) |> List.to_tuple
  end

  def announce(score) when elem(score, 0) >= 0 and elem(score, 1) >= 0 do
    score_mapping = {"Love", "Fifteen", "Thirty", "Forty"}
    {server, player} = score
    case {server, player} do
      {0, 0} -> "Start Game!"
      {0, y} when y <= 3 -> "Love - "<> elem(score_mapping, y)
      {x, 0} when x <= 3 -> elem(score_mapping, x)<>" - Love"
      {x, y} when x == y and x < 3 and y < 3 -> elem(score_mapping, x)<>" - All"
      {x, y} when x <= 3 and y <= 3 and x + y < 6 -> elem(score_mapping, x)<>" - "<>elem(score_mapping, y)
      {3, 3} -> "Deauce"
      {4, 3} -> "Advantage to Server"
      {3, 4} -> "Advantage to Plaer"
      {x, 4} when x <= 2 -> "Game Set Player Win"
      {4, x} when x <= 2 -> "Game Set Server Win"
      {5, 3} -> "Game Set Server Win"
      {3, 5} -> "Game Set Player Win"
      _ -> score
    end
  end
end