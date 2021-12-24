# Code can be cloned at: github.com/rgfaber/robex

defmodule Looping.Tests do
  use ExUnit.Case

  #  Sum tests

  test "Sum of an empty list must return 0 - naive" do
    assert Looping.Sum.sum_of([]) == 0
  end

  test "Calculate the sum of a list of numbers [15,22,5] must return 42 -naive" do
    assert Looping.Sum.sum_of([15, 22, 5]) == 42
  end

  test "Calculate tail-recursive sum of empty list" do
    assert Looping.Sum.tail_recursive_sum_of([]) == 0
  end

  test "Calculate tail recursive sum of [15,22,5] -> 42" do
    assert Looping.Sum.tail_recursive_sum_of([15, 22, 5]) == 42
  end

  # ListLen tests

  test "Test that the length of an empty list is 0" do
    assert Looping.ListLen.length_of_list([]) == 0
  end

  test "Test that the length of [32,87,-5,7,-22] is 5" do
    assert Looping.ListLen.length_of_list([32, 87, -5, 7, -22]) == 5
  end

  # Range tests  
  test "Test that the range between two equal numbers is that number" do
    assert Looping.Ranger.get_range(42, 42) == 42
  end

  test "Test that the range between two adjacent numbers is undefined" do
    assert Looping.Ranger.get_range(4, 5) == :undefined
  end

  test "Test when negative integers are not supported" do
    assert Looping.Ranger.get_range(-5, 3) == :negatives_not_supported
  end

  test "Test when a must be smaller than b" do
    assert Looping.Ranger.get_range(8, 2) == :reverse_order_not_supported
  end

  test "Test when a range of two non adjacent positive integers contains all integers in between" do
    assert Looping.Ranger.get_range(4, 8) == [4, 5, 6, 7, 8]
  end

  test "Positives: An empty list must return an empty list" do
    assert Looping.Positives.get_positives([]) == []
  end

  test "Positives: Must return the positives in a list" do
    assert  Looping.Positives.get_positives([-1, 0, 8, -9, 42, -7, -4]) == [0, 8, 42]
  end






end