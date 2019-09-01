defmodule MyModule do
    def check(order, num, path) do
        len = Enum.count(order)
        if rem(len, 2) == 0 do
            {list1, list2} = Enum.split(order, div(len,2))
            if (Enum.at(list1, -1) != 0 || Enum.at(list2, -1) != 0) do
                fung1 = List.foldl(list1, 0, fn x, acc -> 10 * acc + x end)
                fung2 = List.foldl(list2, 0, fn x, acc -> 10 * acc + x end)
                if fung1 <= fung2 && fung1 * fung2 == num do
                    IO.puts(Enum.join([num, fung1, fung2], " "))
                    File.write(path, Enum.join([num, fung1, fung2], " ") <> "\n", [:append])
                end
            end
        end
    end

    def _should_swap?(list, start, curr) do
        curr-1 < 0 or not Enum.at(list, curr) in Enum.slice(list, start..(curr-1))
    end

    def permutation(list, index, n, num, path) do
        if index == n do
            check(list, num, path)
        else
            at_index =  Enum.at(list, index)
            for i <- index..n-1 do
                at_i = Enum.at(list, i)
                if _should_swap?(list, index, i) do
                    new_list = List.replace_at(list, i, at_index)
                    new_list = List.replace_at(new_list, index, at_i)
                    permutation(new_list, index + 1, n, num, path)
                end
            end
        end
    end

    def isVampire(num, path) do
        digits = Integer.digits(num)
        async_actor =
            fn (num, path, digits) ->
                spawn(fn ->
                    permutation(digits, 0, length(digits), num, path)
                end)
            end
        # permutation(digits, 0, length(digits), num, path)
        async_actor.(num, path, digits)
    end

end





