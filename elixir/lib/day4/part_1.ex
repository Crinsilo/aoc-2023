defmodule DayFourPartOne do
  def solution() do
    line_data =
      File.read!("#{__DIR__}/input.txt")
      |> String.split("\n")
      |> Enum.map(&prep_line_data/1)

    winning_numbers_map =
      line_data
      |> Enum.map(&create_map_from_winning_numbers/1)
      |> Enum.with_index(fn line_array, line_number -> {line_array, line_number} end)
      |> Enum.into(%{}, fn {line_array, line_number} -> {line_number, line_array} end)

    line_data
    |> Enum.with_index(fn line_array, line_number -> {line_array, line_number} end)
    |> Enum.map(fn {line_array, line_number} ->
      calculate_score_from_line_array(line_array, line_number, winning_numbers_map)
    end)
    |> Enum.sum()
  end

  def prep_line_data(line) do
    line
    |> String.split(": ")
    |> tl()
    |> hd()
    |> String.split(" | ")
  end

  def create_map_from_winning_numbers(line_array) do
    hd(line_array)
    |> String.split(" ")
    |> Enum.filter(fn str -> str != "" end)
    |> Enum.into(%{}, fn str_num -> {str_num, true} end)
  end

  def calculate_score_from_line_array(line_array, line_number, winning_numbers_map) do
    tl(line_array)
    |> hd()
    |> String.split(" ")
    |> Enum.filter(fn str -> filter_winning_number(str, line_number, winning_numbers_map) end)
    |> calculate_score_per_line()
  end

  def calculate_score_per_line([]), do: 0

  def calculate_score_per_line(list) when is_list(list) do
    2 ** (length(list) - 1)
  end

  def filter_winning_number(str, line_number, winner_numbers_map) do
    val =
      Map.get(winner_numbers_map, line_number)
      |> Map.get(str)

    val != nil
  end
end

DayFourPartOne.solution()
|> IO.inspect(limit: :infinity, charlists: :as_lists)
