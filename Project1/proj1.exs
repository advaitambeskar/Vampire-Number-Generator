[s1, s2] = System.argv
{:ok, pid} = VampireNumberReciever.start_link

[n1, n2] = [String.to_integer(s1), String.to_integer(s2)]
len1 = length(Integer.digits(n1))
len2 = length(Integer.digits(n2))

if (len1 == len2) do
    VampireNumber.find_in_range_same_length(n1, n2, pid)
else
    """
    For example 100-200000
    call find_in_range() for 100-99999
    call find_in_range_same_length() for 100000-200000
    

    Since 100-99999 has much less computation than 100000-200000,
    We can assign 100-99999 to a single process,
    and divide 100000-200000 into 16 or 32 baskets and then assign to processes.


    find_in_range_same_length() optimizes the searching range for fung1, so that
    it's more efficient when passing a chunk of the range (numbers in the range must have the same length). 
    """

    VampireNumber.find_in_range(n1, trunc(:math.pow(10,len2-1))-1, pid)
    VampireNumber.find_in_range_same_length(trunc(:math.pow(10,len2-1)), n2, pid)
end

# VampireNumber.find_in_range(n1, n2, pid)


VampireNumberReciever.write(pid)
