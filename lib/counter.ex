defmodule Score do
    def game_start do
        %{server: {} , player: {}}
    end
    def to_server(score) do
        Map.update!(score, :server, &(Tuple.append(&1, '1')))
    end
    def to_player(score) do
        Map.update!(score, :player, &(Tuple.append(&1, '1')))
    end
end