defmodule DigitPermutation do
  def main(number) do
    digits = digitsInNumber(number)
    length = length(digits)
    expanded_list = list_expander(digits, length)
    # create a list of 0, with total number of digits equal to half the length of the number
    # attempt using the binary counter methodology for the same
    counter_list = Enum.to_list(1..(div(length,2)))
    counter_list = Enum.map(counter_list, fn(x) -> x - x end)

    list_of_numbers = binary_counter(expanded_list, counter_list, length)

  end

  def binary_counter(expanded_list, counter, length) do

  end
  def list_expander(list_values, length) do
    length = length - 1
    if length != 0 do
      [list_values] ++ list_expander(list_values, length)
    else
      [list_values]
    end
  end

  def digitsInNumber(number) do
    if number === 0 do
      []
    else
    digitsInNumber(div(number,10)) ++  [rem(number, 10)]
    end
  end

end
