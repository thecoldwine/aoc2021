defmodule Aoc2021.Day1 do
  def run(filepath) do
    File.stream!(filepath)
    |> Stream.map(fn e -> Integer.parse(e) |> elem(0) end)
    |> Enum.reduce({nil, 0}, fn e, {prev, total} ->
      cond do
        prev < e -> {e, total + 1}
        true -> {e, total}
      end
    end)
  end
end
