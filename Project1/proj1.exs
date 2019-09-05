[s1, s2] = System.argv
{:ok, pid} = VampireNumberReciever.start_link

[n1, n2] = [String.to_integer(s1), String.to_integer(s2)]

[n1, n2] = [min(n1,n2), max(n1,n2)]
n1 = max(n1, 100)
n2 = max(n2, 200)

VampireNumber.find_in_range(n1, n2, pid)
VampireNumberReciever.write(pid)
