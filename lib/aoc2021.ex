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
      |> Stream.map(&String.trim/1)
    end


    defp reduce_aimless("forward " <> val, {x, y}), do: {x + String.to_integer(val), y}
    defp reduce_aimless("up " <> val, {x, y}), do: {x, y - String.to_integer(val)}
    defp reduce_aimless("down " <> val, {x, y}), do: {x, y + String.to_integer(val)}

    def run2_1(filename) do
      {x, y} = read_input(filename)
               |> Enum.reduce({0, 0}, &reduce_aimless/2)

      x * y
    end

    defp reduce_aimed("forward " <> val, {x, y, aim}) do
      v = String.to_integer(val)
      {x + v, y + aim * v, aim}
    end

    defp reduce_aimed("up " <> val, {x, y, aim}), do: {x, y, aim - String.to_integer(val)}
    defp reduce_aimed("down " <> val, {x, y, aim}), do: {x, y, aim + String.to_integer(val)}

    def run2_2(filename) do
      {x, y, _} = read_input(filename)
                    |> Enum.reduce({0, 0, 0}, &reduce_aimed/2)

      x * y
    end
  end
end
