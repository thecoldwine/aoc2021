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

  defmodule Day2 do
    defp read_input(filename) do
      File.stream!(filename)
      |> Stream.map(fn v ->
        [dir, val] = String.trim(v) |> String.split(" ")

        {String.to_atom(dir), String.to_integer(val)}
      end)
    end

    def run2_1(filename) do
      {x, y} = read_input(filename)
               |> Enum.reduce({0, 0}, fn {d, v}, {x, y} ->
                    case d do
                      :forward -> {x + v, y}
                      :up -> {x, y - v}
                      :down -> {x, y + v}
                    end
                  end)

      x * y
    end
  end
end
