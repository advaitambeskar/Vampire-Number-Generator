# connect to all available nodes (need to configure the ip of each machine)
# send the list of nodes to distributor
# Distributor divide the range into #nodes * #workers_each_node baskets
# Distributor spawn processes for

# iex --name alice@127.0.0.1
Node.start :"alice@127.0.0.1"
Node.connect :"frank@127.0.0.1"
Node.connect :"bob@127.0.0.1"
node_list = Node.list()

[s1, s2] = System.argv
[n1, n2] = [String.to_integer(s1), String.to_integer(s2)]
n1 = max(n1, 100)
n2 = max(n2, 1000)

{:ok, pid_} = VampireNumber.Supervisor.start_link

VampireNumber.Supervisor.assign_task(pid_, node_list, n1, n2)
# VampireNumber.Supervisor.store_result(pid_, "abc")

# {:ok, pid} = VampireNumberReciever.start_link

# VampireNumber2.find_in_range_concurrent(n1, n2, pid)

# VampireNumberReciever.write(pid)

# 10000000 200000000