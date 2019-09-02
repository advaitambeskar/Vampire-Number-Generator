[n1, n2] = System.argv
{:ok, pid} = VampireNumberReciever.start_link
VampireNumber.find_in_range(String.to_integer(n1), String.to_integer(n2), pid)
VampireNumberReciever.write(pid)