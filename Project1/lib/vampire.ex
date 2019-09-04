defmodule VampireNumber do    

    @doc """
    @name is_valid?/4
    @desc check whether fang1 * fang2 is in the given range

    fang1: the first fang
    fang2: the second fang
    lower: the starting number for the range
    upper: the ending number for the range
    """
    defp is_valid?(fang1, fang2, lower, upper) do 
        cond do
            fang1 * fang2 < lower || fang1 * fang2 > upper -> false
            rem(fang1, 10) == 0 and rem(fang2, 10) == 0 -> false
            true -> true
        end
    end

    defp calc_loop(chunk, lower, upper, len, pid) do 
        fang2_upper = trunc(:math.pow(10, len))-1
        for fang1<-chunk do # iterate for the fang1         
            for fang2<-fang1..fang2_upper do     # iterate for the fang2 

                if is_valid?(fang1, fang2, lower, upper) do       
                    if Enum.sort(Integer.digits(fang1*fang2)) == 
                        Enum.sort(Integer.digits(fang1)++Integer.digits(fang2)) do
                        VampireNumberReciever.add(pid, {fang1*fang2, fang1, fang2})
                        # IO.puts(Enum.join([fang1*fang2, fang1, fang2], " "))
                    end
                end
            end             
        end
    end

    @doc """
    @name find_in_range_same_length/3
    @desc find all vampire numbers of the range and store in the reciever, 
            only should be called when lower and upper has the same number of digits

    lower: the starting number for the range
    upper: the ending number for the range
    pid: the id of the reciever process
    """
    def find_in_range_same_length(lower, upper, pid) do
        int_len = length(Integer.digits(lower))
        if rem(int_len, 2) == 0 do
            len = div(int_len, 2)
            fang1_range = div(lower, trunc(:math.pow(10,len)-1))..trunc(:math.sqrt(upper))
            fang2_upper = trunc(:math.pow(10, len))-1
            for fang1<-fang1_range do
                for fang2<-fang1..fang2_upper do
                    if is_valid?(fang1, fang2, lower, upper) do       
                        if Enum.sort(Integer.digits(fang1*fang2)) == 
                            Enum.sort(Integer.digits(fang1)++Integer.digits(fang2)) do
                            VampireNumberReciever.add(pid, {fang1*fang2, fang1, fang2})
                        end
                    end
                end
            end
        end
    end

    @doc """
    @name find_in_range_various_length/3
    @desc find all vampire numbers of the range and store in the reciever,
            can be called when lower and upper has differenct number of digits

    lower: the starting number for the range
    upper: the ending number for the range
    pid: the id of the reciever process
    """
    def find_in_range_various_length(lower, upper, pid) do
        min_len = length(Integer.digits(lower))
        max_len = length(Integer.digits(upper))
        # find numbers in the range with even length
        num_lens = Enum.filter(min_len..max_len, fn x -> rem(x, 2) == 0 end)
        for num_len<-num_lens do
            len = div(num_len, 2)
            fang1_range = trunc(:math.pow(10, len-1))..trunc(:math.pow(10, len))-1 
            calc_loop(fang1_range, lower, upper, len, pid)
        end
    end

    @doc """
    @name find_in_range/4
    @desc concurrently find all vampire numbers of the range and store in reviever

    lower: the starting number for the range
    upper: the ending number for the range
    pid: the id of the reciever process
    worker_num: the number of processes to spawn
    """
    def find_in_range(lower, upper, pid, worker_num \\ 16) do
        min_len = length(Integer.digits(lower))
        max_len = length(Integer.digits(upper))
        # find numbers in the range with even length
        num_lens = Enum.filter(min_len..max_len, fn x -> rem(x, 2) == 0 end)

        for num_len<-num_lens do
            len = div(num_len, 2)
            fang1_range = trunc(:math.pow(10, len-1))..trunc(:math.pow(10, len))-1 
            
            fang1_chunks = Enum.chunk_every(fang1_range, div(Enum.count(fang1_range), worker_num))

            parent = self()
            refs = Enum.map(0..worker_num-1, fn n ->
                ref = make_ref()
                chunk = Enum.at(fang1_chunks, n)
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







