defmodule DayTwoPartOneTest do
  use ExUnit.Case
  doctest DayTwoPartOne

  test "test get_integer_of_color" do
    assert DayTwoPartOne.get_integer_of_color("5 red", " red") == [5, " red"]
    assert DayTwoPartOne.get_integer_of_color("20 green", " green") == [20, " green"]
    assert DayTwoPartOne.get_integer_of_color("14 blue", " blue") == [14, " blue"]
  end

  test "test create_arr_from_string" do
    assert DayTwoPartOne.create_arr_from_string("5 red", [0, 0, 0]) == [5, 0, 0]
    assert DayTwoPartOne.create_arr_from_string("7 green", [0, 0, 0]) == [0, 7, 0]
    assert DayTwoPartOne.create_arr_from_string("20 blue", [0, 0, 0]) == [0, 0, 20]
  end

  test "test get_count_per_set" do
    assert DayTwoPartOne.get_count_per_set("3 green, 6 blue, 6 red") == [6, 3, 6]
    assert DayTwoPartOne.get_count_per_set("12 green, 21 blue, 58 red") == [58, 12, 21]
  end

  test "test check_conditions" do
    assert DayTwoPartOne.check_conditions([[1, 2, 4], [14, 13, 14]], "1") == 0
    assert DayTwoPartOne.check_conditions([[1, 2, 4], [12, 13, 14]], "1") == 1
  end

  test "test get_valid_id" do
    assert DayTwoPartOne.get_valid_id(
             "Game 2: 2 green; 12 red, 5 blue; 2 green, 4 blue, 5 red; 3 green, 6 blue, 6 red; 6 blue, 1 green"
           ) == 2

    assert DayTwoPartOne.get_valid_id(
             "Game 2: 2 green; 13 red, 5 blue; 2 green, 4 blue, 5 red; 3 green, 6 blue, 6 red; 6 blue, 1 green"
           ) == 0

    assert DayTwoPartOne.get_valid_id(
             "Game 2: 2 green; 12 red, 14 blue; 2 green, 4 blue, 5 red; 3 green, 6 blue, 6 red; 6 blue, 1 green"
           ) == 2

    assert DayTwoPartOne.get_valid_id(
             "Game 2: 2 green; 12 red, 16 blue; 2 green, 4 blue, 5 red; 3 green, 6 blue, 6 red; 6 blue, 1 green"
           ) == 0

    assert DayTwoPartOne.get_valid_id(
             "Game 2: 2 green; 12 red, 5 blue; 13 green, 4 blue, 5 red; 3 green, 6 blue, 6 red; 6 blue, 1 green"
           ) == 2

    assert DayTwoPartOne.get_valid_id(
             "Game 2: 2 green; 12 red, 5 blue; 25 green, 4 blue, 5 red; 3 green, 6 blue, 6 red; 6 blue, 1 green"
           ) == 0
  end
end
