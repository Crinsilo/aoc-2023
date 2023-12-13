defmodule DayTwoPartTwo do
  def solution do
    File.read!("#{__DIR__}/input.txt")
    |> String.split("\n")
    |> Enum.map(&get_minimum_cubes_per_line/1)
    |> Enum.reduce(0, fn [a, b, c], acc -> acc + a * b * c end)
  end

  def get_minimum_cubes_per_line(line) do
    [_ | [tail | _]] = String.split(line, ": ")

    tail
    |> String.split("; ")
    |> Enum.reduce([0, 0, 0], &cubes_per_set/2)
  end

  def cubes_per_set(set, acc) do
    set
    |> String.trim()
    |> String.split(", ")
    |> Enum.reduce(acc, &extract_cube_number_from_string/2)
  end

  def extract_cube_number_from_string(str, acc) do
    cond do
      String.contains?(str, "red") ->
        str
        |> get_cube_number_from_string(" red")
        |> update_cube_count(" red", acc)

      String.contains?(str, "green") ->
        str
        |> get_cube_number_from_string(" green")
        |> update_cube_count(" green", acc)

      String.contains?(str, "blue") ->
        str
        |> get_cube_number_from_string(" blue")
        |> update_cube_count(" blue", acc)
    end
  end

  def get_cube_number_from_string(str, color) do
    str
    |> String.trim()
    |> String.replace(color, "")
    |> String.to_integer()
  end

  def update_cube_count(int, " red", [a, b, c]) when int > a, do: [int, b, c]
  def update_cube_count(int, " green", [a, b, c]) when int > b, do: [a, int, c]
  def update_cube_count(int, " blue", [a, b, c]) when int > c, do: [a, b, int]
  def update_cube_count(_, _, acc), do: acc
end
