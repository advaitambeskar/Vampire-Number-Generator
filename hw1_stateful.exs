defmodule VampireStateful do

  use Agent

  import RangeVampire, only: [rangeAccepter: 2]

  def agent_creator(num1, num2) do
    if ((num1 - num2) <= 10000000) do
      {:ok, pid} = Agent.start_link(num1, num2)
    else
      large_range_agents(num1, num2)
    end
  end

  def large_range_agents(num1, num2) do
    if(num1 - num2 <= 10000000) do
      {:ok, pid} = Agent.start_link(num1, num2)
    else
      {:ok, pid} = Agent.start_link(num1, num1 + 10000000)
      large_range_agents(num1 + 10000000, num2)
    end
  end

  def start_link(num1, num2) do
    Agent.start_link(fn ->
      IO.puts ("something")
      # You have to pass the numbers to the hw1_cont function and start printing outputs
      rangeAccepter(num1, num2)
    end)
  end

  def put(pid, key, value) do
    Agent.update(pid, &Map.put(&1, key,value))
  end

  def get(pid, key) do
    Agent.get(pid, &Map.get(&1, key))
  end
end
