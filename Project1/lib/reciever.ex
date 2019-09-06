
defmodule VampireNumberReciever do
    @moduledoc """
    Generates a genserver procedure to accept the range and then print the answer.
    """
    use GenServer

    def start_link do
		GenServer.start_link(__MODULE__, %{})
    end

    def add(process_id, tuple) do
        GenServer.call(process_id, {:add, tuple})
    end

    def write(process_id) do
        GenServer.call(process_id, {:write})
    end

    @doc """
    Receive answers from VampireNumber and store them in a map
    """
    def handle_call({:add, tuple}, _, answers) do

        {vampire, fung1, fung2} = tuple
        if Map.has_key?(answers, vampire) do
            answers = Map.update!(answers, vampire, fn list->[fung1,fung2 | list] end)
            {:reply, [], answers}
        else
            answers = Map.put(answers, vampire, [fung1, fung2])
            {:reply, [], answers}
        end

    end

    @doc """
    Out put the answers from the map
    """
    def handle_call({:write}, _, answers) do

        Enum.each answers,  fn {k, v} ->
            IO.puts "#{k} #{Enum.join(v, " ")}"
        end
        # IO.puts(Enum.count(answers))
        {:reply, [], answers}
    end


end
