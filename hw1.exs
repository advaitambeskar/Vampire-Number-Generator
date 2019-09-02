# generate all the enumerations of the given length
# defmodule Enumerations do
#     def of(0) do
#         [[]]
#     end

#     def of(len) when len > 0 do
#         for h <- 0..9, t <- of(len-1), do: [h | t]
#     end
# end

# measure running time
defmodule Timer do
  def measure(function) do
    function
    |> :timer.tc
    |> elem(0)
    |> Kernel./(1_000_000)
  end
end


defmodule VampireNumber do

    # check whether fung1 * fung2 is in the given range
    defp is_valid?(fung1, fung2, lower, upper) do
        cond do
            # fung2 < fung1 -> false
            fung1 * fung2 < lower || fung1 * fung2 > upper -> false
            rem(fung1, 10) == 0 and rem(fung2, 10) == 0 -> false
            true -> true
        end
    end

    def find_in_range(lower, upper) do
        min_len = length(Integer.digits(lower))
        max_len = length(Integer.digits(upper))
        # find numbers in the range with even length
        num_lens = Enum.filter(min_len..max_len, fn x -> rem(x, 2) == 0 end)

        for num_len<-num_lens do
            len = div(num_len, 2)
            # all_enums = Enumerations.of(len) # get all enumerations
            # all_nums = Enum.map(all_enums, fn list-> List.foldl(list, 0, fn x, acc -> 10 * acc + x end) end)

            for fung1<- trunc(:math.pow(10, len-1))..trunc(:math.pow(10, len))-1 do # iterate for the fung1
                # create a BEAM process for each fung1. (about 5 times faster after using it)
                spawn(fn ->
                    for fung2<- fung1..trunc(:math.pow(10, len))-1 do     # iterate for the fung2
                        if is_valid?(fung1, fung2, lower, upper) do
                            if Enum.sort(Integer.digits(fung1*fung2)) ==
                                Enum.sort(Integer.digits(fung1)++Integer.digits(fung2)) do
                                IO.puts(Enum.join([fung1*fung2, fung1, fung2], " "))
                            end
                        end
                    end
                end
                )
            end
        end
    end
end

time = Timer.measure(fn->
    VampireNumber.find_in_range(1000000000, 2000000000)
    # IO.inspect(return_list)
    # flattened_list = return_list |> List.foldl([], &(&1 ++ &2)) |> List.foldl([], &(&1 ++ &2))
    # IO.inspect(Enum.filter(flattened_list, fn x -> x != nil end))
    end
)
IO.puts(time)

# all_enums = Enumerations.of(3) # get all enumerations
# all_nums = Enum.map(all_enums, fn list-> List.foldl(list, 0, fn x, acc -> 10 * acc + x end) end)
# for num<-all_nums, do: IO.puts(num)


# Enumerations.of(6)



# for num<-100000..200000 do
#     MyModule.isVampire2(num)
# end
# result_path = "./result.txt"
# if File.exists?(result_path), do: File.rm(result_path)
# File.touch(result_path)
# MyModule.isVampire(1000174288, result_path)
# MyModule.isVampire(125460, result_path)
# MyModule.isVampire(1254601234, result_path)
# MyModule.isVampire(1254601234789, result_path)




