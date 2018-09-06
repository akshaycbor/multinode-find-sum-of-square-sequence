defmodule Parent do
    use Supervisor

    def start_link(limits) do
        Supervisor.start_link(__MODULE__, limits)
    end

    def init([limit|max_length]) do
        chunked_lists = Enum.chunk_every(Enum.to_list(1..limit), 1000)
        children = Enum.map( chunked_lists, fn(x) -> 
            worker(Child, [{x,max_length}], [id: x, restart: :transient]) 
        end )
        
        supervise(children, strategy: :one_for_one)
    end
end

defmodule Child do
    
    def start_link(limits) do
        pid = spawn_link(__MODULE__, :init, [limits])
        {:ok, pid}
    end

    def init({chunked_list,max_length}) do
        Enum.each chunked_list, fn first_number ->
            x = get_sum_of_squares(first_number, Enum.at(max_length,0))
            x = :math.sqrt(x)
            if x==trunc(x) do 
                IO.puts(first_number) 
            end
        end
    end

    def get_sum_of_squares(x, 1) do x*x end
    def get_sum_of_squares(x, max_length) do x*x + get_sum_of_squares(x+1, max_length-1) end
end

Parent.start_link([1000000,4])

Process.sleep 10_000