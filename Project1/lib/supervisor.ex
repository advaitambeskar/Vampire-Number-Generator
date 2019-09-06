
defmodule VampireNumber.Supervisor do
    use GenServer

    def start_link do
		GenServer.start_link(__MODULE__, [])
    end

    def assign_task(process_id, node_list, n1, n2) do
        GenServer.call(process_id, {:assign_task, node_list, n1, n2}, :infinity)
    end

    def handle_call({:assign_task, node_list, n1, n2}, _, answer_list) do
        cnt = length(node_list)
        
        # chunks = Enum.chunk_every(n1..n2, div(n2-n1, cnt)+1) # TODO: imporve chunk function
        # chunks = if rem(n2-n1+1,cnt) == 0, do: Enum.chunk_every(n1..n2, div(n2-n1+1, cnt)),
        #         else: Enum.chunk_every(n1..n2, div(n2-n1+1, cnt)+1)
        starts = :lists.seq(n1, n2, div(n2-n1+1, cnt))
        ends = Enum.map(tl(starts), fn x->x-1 end) ++ [n2]
        ranges = Enum.zip(starts, ends) |> Enum.map(fn {x,y}->[x,y] end)
        IO.inspect(ranges)
        # ranges = Enum.map(chunks, fn list -> Enum.take(list, 1) ++ Enum.take(list, -1) end)
        parent = self()      

        refs = for {node, range} <- Enum.zip(node_list, ranges) do
            [lower, upper] = range
            ref = make_ref()
            Node.spawn(node, fn() -> 
                {:ok, pid} = VampireNumberReciever.start_link
                VampireNumber.find_in_range_concurrent(lower, upper, pid)
                return_value = VampireNumberReciever.send_state(pid)
                send(parent, {:done, ref, return_value})
            end)
            ref
        end

        Enum.each(refs, fn ref ->
            receive do
                {:done, ref, result} -> :ok
                Enum.each result,  fn {k, v} ->
                    IO.puts "#{k} #{Enum.join(v, " ")}" 
                end
            end
        end)
        {:reply, [], answer_list}
    end

end

 