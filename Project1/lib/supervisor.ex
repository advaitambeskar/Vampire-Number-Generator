# """
# List all the nodes
# Assign a range to each nodes
# """
# defmodule VampireNumber.Supervisor do
#     use Supervisor
  
#     def start_link(range) do
#         Supervisor.start_link(__MODULE__, range)
#     end
  
#     def init(range) do
#         [n1, n2] = range
#         len1 = length(Integer.digits(n1))
#         len2 = length(Integer.digits(n2))

#         if (len1 == len2) do
#             VampireNumber.find_in_range_same_length(n1, n2, pid)
#         else
#             VampireNumber.find_in_range_various_length(n1, trunc(:math.pow(10,len2-1))-1, pid)
#             VampireNumber.find_in_range_same_length(trunc(:math.pow(10,len2-1)), n2, pid)
#         end

#         children = Enum.map(limits, fn(limit_num) ->
#         worker(Child, [limit_num], [id: limit_num, restart: :permanent])
#         end)
  
#         supervise(children, strategy: :one_for_one)
#     end
#   end

 