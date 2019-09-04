defmodule VampireNumber do    

    # check whether fung1 * fung2 is in the given range
    defp is_valid?(fung1, fung2, lower, upper) do 
        cond do
            # fung2 < fung1 -> false
            fung1 * fung2 < lower || fung1 * fung2 > upper -> false
            rem(fung1, 10) == 0 and rem(fung2, 10) == 0 -> false
            true -> true
        end
    end

    def calc_loop(chunk, lower, upper, len, pid) do 
        fung2_upper = trunc(:math.pow(10, len))-1
        for fung1<-chunk do # iterate for the fung1         
            for fung2<-fung1..fung2_upper do     # iterate for the fung2 

                if is_valid?(fung1, fung2, lower, upper) do       
                    if Enum.sort(Integer.digits(fung1*fung2)) == 
                        Enum.sort(Integer.digits(fung1)++Integer.digits(fung2)) do
                        VampireNumberReciever.add(pid, {fung1*fung2, fung1, fung2})
                        # IO.puts(Enum.join([fung1*fung2, fung1, fung2], " "))
                    end
                end
            end             
        end
    end

    # call this only if the lower and upper bounds have the same length
    def find_in_range_same_length(lower, upper, pid) do
        int_len = length(Integer.digits(lower))
        if rem(int_len, 2) == 0 do
            len = div(int_len, 2)
            fung1_range = div(lower, trunc(:math.pow(10,len)-1))..trunc(:math.sqrt(upper))
            fung2_upper = trunc(:math.pow(10, len))-1
            for fung1<-fung1_range do
                for fung2<-fung1..fung2_upper do
                    if is_valid?(fung1, fung2, lower, upper) do       
                        if Enum.sort(Integer.digits(fung1*fung2)) == 
                            Enum.sort(Integer.digits(fung1)++Integer.digits(fung2)) do
                            VampireNumberReciever.add(pid, {fung1*fung2, fung1, fung2})
                            # IO.puts(Enum.join([fung1*fung2, fung1, fung2], " "))
                        end
                    end
                end
            end
        end
    end

    def find_in_range(lower, upper, pid, worker_num \\ 16) do
        min_len = length(Integer.digits(lower))
        max_len = length(Integer.digits(upper))
        # find numbers in the range with even length
        num_lens = Enum.filter(min_len..max_len, fn x -> rem(x, 2) == 0 end)

        for num_len<-num_lens do
            len = div(num_len, 2)
            fung1_range = trunc(:math.pow(10, len-1))..trunc(:math.pow(10, len))-1 
            
            fung1_chunks = Enum.chunk_every(fung1_range, div(Enum.count(fung1_range), worker_num))

            parent = self()
            refs = Enum.map(0..worker_num-1, fn n ->
                ref = make_ref()
                chunk = Enum.at(fung1_chunks, n)
                spawn_link(fn -> calc_loop(chunk, lower, upper,len, pid); send(parent, {:done, ref}) end)
                ref
            end)

            # wait for all spawned processes to finish
            Enum.each(refs, fn ref ->
                receive do
                    {:done, ref} -> :ok
                end
            end)

        end


    end
end


defmodule VampireNumberReciever do
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

    def handle_call({:write}, _, answers) do
        Enum.each answers,  fn {k, v} ->
            IO.puts "#{k} #{Enum.join(v, " ")}"
        end 
        IO.puts(Enum.count(answers))
        {:reply, [], answers}
    end


end







