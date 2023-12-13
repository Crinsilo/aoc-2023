defmodule DayonePartOne do
  def solution(file_path) do
    {:ok, contents} = File.read(file_path)

    contents
    |> String.split("\n")
    |> Enum.map(&DayonePartOne.extract_numbers/1)
    |> Enum.sum()
    |> IO.puts()
  end

  def extract_numbers(str) do
    str
    |> String.graphemes()
    |> Enum.filter(&DayonePartOne.parse_number/1)
    |> Enum.join()
    |> DayonePartOne.check_count_and_duplicate()
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

DayonePartOne.solution("input.txt")
