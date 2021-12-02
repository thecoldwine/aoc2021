defmodule Aoc2021 do
  defmodule Day1 do
    def run1_1(filepath), do: to_integer_stream(filepath) |> count()

    def run1_2(filepath), do: to_integer_stream(filepath) |> window_count()

    defp to_integer_stream(filepath) do
      File.stream!(filepath)
      |> Stream.map(fn e -> Integer.parse(e) |> elem(0) end)
    end

    def count(stream) do
      stream
      |> Enum.reduce({nil, 0}, fn e, {prev, total} ->
        cond do
          prev < e -> {e, total + 1}
          true -> {e, total}
        end
      end)
    end

    def window_count(stream) do
      stream
      |> Stream.transform([nil, nil, nil], fn e, [_, b, c] -> {[b, c, e], [b, c, e]} end)
      |> Stream.drop(6)
      |> Stream.chunk_every(3)
      |> Stream.map(&Enum.sum/1)
      |> count
    end
  end
end
