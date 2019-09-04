:observer.start()
[s1, s2] = System.argv
{:ok, pid} = VampireNumberReciever.start_link

[n1, n2] = [String.to_integer(s1), String.to_integer(s2)]


VampireNumber.find_in_range(n1, n2, pid)
VampireNumberReciever.write(pid)
