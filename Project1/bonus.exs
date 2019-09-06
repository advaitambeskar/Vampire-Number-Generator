# connect to all available nodes (need to configure the ip of each machine)
# send the list of nodes to distributor
# Distributor divide the range into #nodes * #workers_each_node baskets
# Distributor spawn processes for

# iex --name alice@127.0.0.1

Node.start :"master@10.136.84.235"
Node.set_cookie :somecookie
# Node.connect :"advait@10.136.192.30"
# Node.connect :"bob@127.0.0.1"
# Node.connect :"Aotian@10.136.114.150" 
Node.connect :"aotian@10.136.84.235"

node_list = Node.list()
IO.inspect(node_list)
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