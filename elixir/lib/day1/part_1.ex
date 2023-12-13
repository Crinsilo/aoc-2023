defmodule DayOnePartOne do
  def solution() do
    File.read!("#{__DIR__}/input.txt")
    |> String.split("\n")
    |> Enum.map(&extract_numbers/1)
    |> Enum.sum()
  end

  def extract_numbers(str) do
    str
    |> String.graphemes()
    |> Enum.filter(&parse_number/1)
    |> Enum.join()
    |> check_count_and_duplicate()
  end

  def parse_number(c) do
    case Integer.parse(c) do
      {int, _rest} -> int
      :error -> false
    end
  end

  def check_count_and_duplicate(str) do
    if String.length(str) < 2 do
      String.duplicate(str, 2)
      |> String.to_integer()
    else
      (String.first(str) <> String.last(str))
      |> String.to_integer()
    end
  end
end
