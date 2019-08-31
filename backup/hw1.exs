defmodule MyModule do
    def isVampire(num) do
        permutation(Enum.count(Integer.digits(num)), [], num)
    end

    def permutation(len, prefix, num) do
        if Enum.count(prefix) == len do # all digits are ready
            check(prefix, num)
        else
            for i <- 0..len-1 do
                if prefix -- [i] == prefix do # i doesn't appear in prefix
                    prefix = prefix ++ [i]
                    permutation(len, prefix, num)
                    prefix = prefix |> Enum.reverse() |> tl() |> Enum.reverse() # remove the last element
                end
            end
        end
    end

    def check(order, num) do
        digits = Enum.sort(Integer.digits(num))
        len = Enum.count(digits)
        if rem(len, 2) == 0 do
            {list1, list2} = Enum.split(order, div(len,2))
            list1 = Enum.map(list1, fn x -> Enum.at(digits, x) end)
            list2 = Enum.map(list2, fn x -> Enum.at(digits, x) end)
            if (Enum.at(list1, -1) != 0 || Enum.at(list2, -1) != 0) do
                fung1 = List.foldl(list1, 0, fn x, acc -> 10 * acc + x end)
                fung2 = List.foldl(list2, 0, fn x, acc -> 10 * acc + x end)
                if fung1 <= fung2 && fung1 * fung2 == num, do: IO.puts(Enum.join([fung1, fung2], " "))
            end
        end
    end

end






