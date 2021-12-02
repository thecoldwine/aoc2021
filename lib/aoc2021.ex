defmodule Aoc2021 do
  defmodule Day1 do
    def count(filepath) do
      File.stream!(filepath)
      |> Stream.map(fn e -> Integer.parse(e) |> elem(0) end)
      |> Enum.reduce({nil, 0}, fn e, {prev, total} ->
        cond do
          prev < e -> {e, total + 1}
          true -> {e, total}
        end
      end)
    end

    def window_count(filepath) do
      File.stream!(filepath)
      |> Stream.map(fn e -> Integer.parse(e) |> elem(0) end)
      |> Stream.transform([nil, nil, nil], fn e, [_, b, c] -> {[b, c, e], [b, c, e]} end)
      |> Stream.drop(6)
      |> Stream.chunk_every(3)
      |> Stream.map(&Enum.sum/1)
      |> Enum.reduce({nil, 0}, fn e, {prev, total} ->
        cond do
          prev < e -> {e, total + 1}
          true -> {e, total}
        end
      end)
    end
  end
end
