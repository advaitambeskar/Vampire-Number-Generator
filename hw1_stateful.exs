defmodule VampireStateful do

  use Agent

  import VampireNumber, only: [find_in_range: 2]

  def agent_creator(num1, num2) do
    if ((num1 - num2) <= 10000000) do
      large_range_agents(num1, num2, 100000)
    else
      large_range_agents(num1, num2, 10000000)
    end
  end

  def large_range_agents(num1, num2, range) do
    if(num1 - num2 <= range) do
      {:ok, pid} = Agent.start_link(num1, num2)
    else
      {:ok, pid} = Agent.start_link(num1, num1 + range)
      large_range_agents(num1 + range, num2)
    end
  end

  def start_link(num1, num2) do
    Agent.start_link(fn ->
      # You have to pass the numbers to the hw1_cont function and start printing outputs
      find_in_range(num1, num2)
    end)
  end

  def put(pid, key, value) do
    Agent.update(pid, &Map.put(&1, key,value))
  end

  def get(pid, key) do
    Agent.get(pid, &Map.get(&1, key))
  end
end
