defmodule Parent do
    use Supervisor

    def start_link(limits) do
        Supervisor.start_link(__MODULE__, limits)
    end

    def init([limit|max_length]) do
        # IO.puts(limit) 
        children = Enum.map( Enum.to_list(1..limit), fn(x) -> 
            worker(Child, [[x|max_length]], [id: x, restart: :transient]) 
        end )
        
        supervise(children, strategy: :one_for_one)
    end

end

defmodule Child do
    
    def start_link(limits) do
        # IO.puts(Enum.at(limits, 0))
        pid = spawn_link(__MODULE__, :init, [limits])
        {:ok, pid}
    end

    def init([limit|max_length]) do
        x = get_sum_of_squares(limit, Enum.at(max_length,0))
        IO.puts(x)
    end

    def get_sum_of_squares(limit, 1) do limit*limit end
    def get_sum_of_squares(limit, max_length) do limit*limit + get_sum_of_squares(limit+1, max_length-1) end
end

Parent.start_link([4,4])

Process.sleep 10_000