defmodule DayThreePartTwo do
  def solution() do
    input_lines_array =
      File.read!("#{__DIR__}/input.txt")
      |> String.split("\n")

    star_indexes = Enum.map(input_lines_array, &get_star_indexes/1)

    num_line_char_index_map =
      Enum.map(input_lines_array, &get_num_chunks_per_line/1)
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {num_chunk_array, line_number}, acc ->
        Map.merge(acc, create_num_map_for_line(num_chunk_array, line_number))
      end)

    star_indexes
    |> Enum.with_index(fn star_line_indexes, line_number ->
      get_list_of_product_of_star_neighbouring_numbers_per_line(
        star_line_indexes,
        line_number,
        num_line_char_index_map
      )
    end)
    |> List.flatten()
    |> Enum.sum()
  end

  # extract * nodes
  def get_star_indexes(line) do
    line
    |> String.graphemes()
    |> Enum.with_index(fn char, index -> {char, index} end)
    |> Enum.filter(fn {char, _index} -> char == "*" end)
  end

  # extract number chunks with starting and ending index
  def get_num_chunks_per_line(line) do
    line
    |> String.graphemes()
    |> Enum.with_index(fn char, index -> {char, index} end)
    |> Enum.chunk_by(fn {char, _index} -> check_for_number(char) end)
    |> Enum.filter(&filter_number_chunks/1)
    |> Enum.map(&create_num_from_chunk/1)
  end

  def check_for_number(char) do
    Regex.compile!("1|2|3|4|5|6|7|8|9|0")
    |> Regex.run(char)
    |> convert_match_to_bool()
  end

  def convert_match_to_bool(a) when is_list(a), do: true
  def convert_match_to_bool(nil), do: false

  def filter_number_chunks(chunk) do
    {char, _} = hd(chunk)
    check_for_number(char)
  end

  def create_num_from_chunk(chunk) do
    {_, starting_index} = hd(chunk)

    num_str = Enum.reduce(chunk, "", fn {char, _index}, acc -> acc <> char end)

    {num_str, starting_index}
  end

  # create num map of all indexes(combination of line-number and char-index) having number
  def create_num_map_for_line(num_chunk_array, line_number) do
    num_chunk_array
    |> Enum.reduce(%{}, fn {num_str, start_index}, acc ->
      update_num_map_for_tuple(num_str, start_index, acc, line_number)
    end)
  end

  def update_num_map_for_tuple(num_str, start_index, acc, line_number) do
    end_index = start_index + String.length(num_str) - 1

    Enum.reduce(Range.new(start_index, end_index), acc, fn char_index, localAcc ->
      Map.put(localAcc, "#{line_number}-#{char_index}", String.to_integer(num_str))
    end)
  end

  # list of products of number surronding * per line
  def get_list_of_product_of_star_neighbouring_numbers_per_line(
        star_line_indexes,
        line_number,
        num_line_char_index_map
      ) do
    Enum.map(star_line_indexes, fn star_index_instance ->
      get_product_of_star_neighbouring_numbers(
        star_index_instance,
        line_number,
        num_line_char_index_map
      )
    end)
  end

  # multiply two number surrounding *
  def get_product_of_star_neighbouring_numbers(
        {_, star_index},
        line_number,
        num_line_char_index_map
      ) do
    [
      "#{line_number - 1}-#{star_index}",
      "#{line_number - 1}-#{star_index - 1}",
      "#{line_number}-#{star_index - 1}",
      "#{line_number + 1}-#{star_index - 1}",
      "#{line_number + 1}-#{star_index}",
      "#{line_number + 1}-#{star_index + 1}",
      "#{line_number}-#{star_index + 1}",
      "#{line_number - 1}-#{star_index + 1}"
    ]
    |> Enum.map(fn key -> Map.get(num_line_char_index_map, key) end)
    |> Enum.filter(&filter_num/1)
    |> MapSet.new()
    |> MapSet.to_list()
    |> Enum.take(2)
    |> add_valid_neighbours()
  end

  def filter_num(a) when is_nil(a), do: false
  def filter_num(_), do: true

  def add_valid_neighbours(list) do
    if length(list) != 2 do
      0
    else
      Enum.product(list)
    end
  end
end

DayThreePartTwo.solution()
|> IO.inspect()
