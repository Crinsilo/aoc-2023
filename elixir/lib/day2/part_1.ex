defmodule DayTwoPartOne do
  def solution() do
    File.read!("#{__DIR__}/input.txt")
    |> String.split("\n")
    |> Enum.map(&get_valid_id/1)
    |> Enum.sum()
  end

  def get_valid_id(line) do
    [head | [tail | _]] = String.split(line, ": ")
    "Game " <> id = head

    tail
    |> String.split("; ")
    |> Enum.map(&get_count_per_set/1)
    |> check_conditions(id)
  end

  def check_conditions(arr, id) do
    arr
    |> Enum.any?(fn [a, b, c] -> a > 12 || b > 13 || c > 14 end)
    |> return_id_or_zero(id)
    |> String.to_integer()
  end

  def return_id_or_zero(bool, id) do
    if bool, do: "0", else: id
  end

  def get_count_per_set(str) do
    str
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reduce([0, 0, 0], &create_arr_from_string/2)
  end

  def create_arr_from_string(str, acc) do
    [a, b, c] = acc

    cond do
      String.contains?(str, "red") ->
        [int, " red"] = get_integer_of_color(str, " red")
        [int, b, c]

      String.contains?(str, "green") ->
        [int, " green"] = get_integer_of_color(str, " green")
        [a, int, c]

      String.contains?(str, "blue") ->
        [int, " blue"] = get_integer_of_color(str, " blue")
        [a, b, int]

      true ->
        acc
    end
  end

  def get_integer_of_color(str, color) do
    int =
      str
      |> String.replace(color, "")
      |> String.trim()
      |> String.to_integer()

    [int, color]
  end
end
