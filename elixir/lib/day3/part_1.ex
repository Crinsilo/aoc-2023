defmodule DayThreePartOne do
  def solution() do
    input_lines_array =
      File.read!("#{__DIR__}/input.txt")
      |> String.split("\n")

    symbols_map = create_symbols_map(input_lines_array)

    input_lines_array
    |> Enum.map(&chunk_by_line/1)
    |> Enum.with_index(fn line_chunk_array, line_number ->
      get_numbers_with_symbol_per_line(line_chunk_array, line_number, symbols_map)
    end)
    |> List.flatten()
    |> Enum.map(fn {x, _} -> String.to_integer(x) end)
    |> Enum.sum()
  end

  def get_numbers_with_symbol_per_line(line_chunk_array, line_number, symbols_map) do
    Enum.filter(line_chunk_array, fn chunk ->
      check_for_existance_of_symbols_as_neighbours(chunk, line_number, symbols_map)
    end)
  end

  # Function checking conditions
  def check_for_existance_of_symbols_as_neighbours(
        {str_num, starting_index},
        line_number,
        symbols_map
      ) do
    ending_index = starting_index + String.length(str_num) - 1

    Map.get(symbols_map, "#{line_number - 1}-#{starting_index - 1}") ||
      Map.get(symbols_map, "#{line_number}-#{starting_index - 1}") ||
      Map.get(symbols_map, "#{line_number + 1}-#{starting_index - 1}") ||
      Enum.any?(Range.new(starting_index, ending_index), fn char_index ->
        check_above_and_below_for_symbols(char_index, line_number, symbols_map)
      end) ||
      Map.get(symbols_map, "#{line_number - 1}-#{ending_index + 1}") ||
      Map.get(symbols_map, "#{line_number}-#{ending_index + 1}") ||
      Map.get(symbols_map, "#{line_number + 1}-#{ending_index + 1}")
  end

  def check_above_and_below_for_symbols(char_index, line_number, symbols_map) do
    Map.get(symbols_map, "#{line_number - 1}-#{char_index}") ||
      Map.get(symbols_map, "#{line_number + 1}-#{char_index}")
  end

  # Functions extraction numbers per line with starting index
  def chunk_by_line(line) do
    line
    |> String.graphemes()
    |> Enum.with_index(fn char, index -> {char, index} end)
    |> Enum.chunk_by(fn {char, _} -> chunk_condition(char) end)
    |> Enum.filter(&filter_number_chunks/1)
    |> Enum.map(&create_number_index_map/1)
  end

  def chunk_condition(char) do
    Regex.run(~r/1|2|3|4|5|6|7|8|9|0/, char)
    |> convert_to_bool_char()
  end

  def convert_to_bool_char(a) when is_list(a), do: true
  def convert_to_bool_char(nil), do: false

  def filter_number_chunks(list) do
    [{char, _} | _tail] = list
    chunk_condition(char)
  end

  def create_number_index_map(list) do
    [{_, i} | _tail] = list
    val = Enum.reduce(list, "", fn {x, _}, a -> a <> x end)
    {val, i}
  end

  # Functions Creating symbol map below

  def create_symbols_map(input_lines_array) do
    input_lines_array
    |> Enum.with_index(fn line, index -> filter_symbols_per_line(line, index) end)
    |> List.flatten()
    |> Enum.reduce(%{}, fn line_index_char_index_str, acc ->
      Map.put(acc, line_index_char_index_str, true)
    end)
  end

  def filter_symbols_per_line(line, line_index) do
    line
    |> String.graphemes()
    |> Enum.with_index(fn char, char_index -> {char, char_index} end)
    |> Enum.filter(fn {char, _char_index} -> filter_symbols_per_character(char) end)
    |> Enum.map(fn {_char, char_index} -> "#{line_index}-#{char_index}" end)
  end

  def filter_symbols_per_character(char) do
    Regex.compile!("1|2|3|4|5|6|7|8|9|0|\\.")
    |> Regex.run(char)
    |> check_for_non_symbols()
  end

  def check_for_non_symbols(a) when is_list(a), do: false
  def check_for_non_symbols(nil), do: true
end

DayThreePartOne.solution()
|> IO.inspect(limit: :infinity)
