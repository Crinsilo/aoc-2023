defmodule DayOnePartTwo do
  @validMatchMap %{
    "1" => 1,
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9
  }

  @searchRegex "1|2|3|4|5|6|7|8|9|0|one|two|three|four|five|six|seven|eight|nine"

  def solution(file_path) do
    {:ok, contents} = File.read(file_path)

    contents
    |> String.split("\n")
    |> Enum.map(&get_first_and_last_valids/1)
    |> Enum.sum()
    |> IO.puts()
  end

  def get_first_and_last_valids(str) do
    [firstMatch] =
      Regex.compile!(@searchRegex)
      |> Regex.run(str)

    [lastMatch] =
      Regex.compile!(String.reverse(@searchRegex))
      |> Regex.run(String.reverse(str))
      |> Enum.map(&String.reverse/1)

    Map.get(@validMatchMap, firstMatch) * 10 +
      Map.get(@validMatchMap, lastMatch)
  end
end

DayOnePartTwo.solution("input.txt")
