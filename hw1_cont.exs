defmodule RangeVampire do
  # importing the module from the hw1.exs
  import MyModule, only: [isVampire: 2]

  def rangeAccepter(num1, num2) do
    range_in_list = Enum.to_list(num1..num2)
    range_list_chunk = Enum.chunk_every(range_in_list, div((num2 + 1 - num1), 16))
    #IO.inspect(range_list_chunk, charlists: :as_lists)

    async_process =
      fn list_passed ->
        spawn(fn -> accept_list_buckets(list_passed) end)
      end

    for list_buckets <- range_list_chunk do
      async_process.(list_buckets)
    end
  end

  def accept_list_buckets(list_of_values) do
    for element <- list_of_values do
      isVampireNumber(element)
    end
    IO.puts("done")
  end

  def accept_bucket_values(number) do
    IO.puts("The number is #{number}")
  end

  def isVampireNumber(number) do
    result_path = "./result.txt"
    {:ok, file} = File.open(result_path, [:read, :write])
    # IO.puts(number)
    random = isVampire(number, result_path)
    File.close(file)
  end
end
