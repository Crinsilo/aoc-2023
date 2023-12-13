defmodule DayTwoPartOneTest do
  use ExUnit.Case
  doctest DayTwoPartTwo

  test "test get_integer_of_color" do
    assert DayTwoPartTwo.update_cube_count(1, " red", [0, 0, 0]) == [1, 0, 0]
    assert DayTwoPartTwo.update_cube_count(2, " blue", [12, 10, 1]) == [12, 10, 2]
    assert DayTwoPartTwo.update_cube_count(15, " green", [1, 12, 0]) == [1, 15, 0]
  end

  test "test get_cube_number_from_string" do
    assert DayTwoPartTwo.get_cube_number_from_string("5 red", " red") == 5
    assert DayTwoPartTwo.get_cube_number_from_string("20 blue", " blue") == 20
    assert DayTwoPartTwo.get_cube_number_from_string("12 green", " green") == 12
  end

  test "test extract_cube_number_from_string" do
    assert DayTwoPartTwo.extract_cube_number_from_string("5 red", [0, 0, 0]) == [5, 0, 0]
    assert DayTwoPartTwo.extract_cube_number_from_string("20 blue", [12, 10, 1]) == [12, 10, 20]
    assert DayTwoPartTwo.extract_cube_number_from_string("12 green", [1, 10, 0]) == [1, 12, 0]
  end

  test "test cubes_per_set" do
    assert DayTwoPartTwo.cubes_per_set("3 green, 6 blue, 6 red", [0, 0, 0]) == [6, 3, 6]
    assert DayTwoPartTwo.cubes_per_set("1 green, 21 blue, 5 red", [12, 10, 1]) == [12, 10, 21]
    assert DayTwoPartTwo.cubes_per_set("1 green, 2 blue, 5 red", [1, 1, 1]) == [5, 1, 2]
  end

  test "test get_minimum_cubes_per_line" do
    assert DayTwoPartTwo.get_minimum_cubes_per_line(
             "Game 2: 2 green; 15 red, 5 blue; 2 green, 4 blue, 5 red; 3 green, 6 blue, 6 red; 6 blue, 1 green"
           ) == [15, 3, 6]

    assert DayTwoPartTwo.get_minimum_cubes_per_line(
             "Game 76: 9 green, 2 red, 3 blue; 6 red, 13 green, 5 blue; 14 green, 9 red, 2 blue; 1 blue, 6 red, 2 green; 8 red, 10 green, 1 blue; 2 red, 15 green, 7 blue"
           ) == [9, 15, 7]
  end
end
