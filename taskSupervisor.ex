defmodule Supersuper do
    use Application

    def init({limit, max_length}) do
        children = 
            [
                {Task.Supervisor, name: SquareCalc.TaskSupervisor, restart: :transient}
            ]
        Supervisor.start_link(children, strategy: :one_for_one)

        chunks = create_chunks(0, limit, 1000)
        Enum.each chunks, fn chunk ->
            Task.Supervisor.async(SquareCalc.TaskSupervisor, fn -> find_result({chunk, max_length}) end)
        end
    end

    def create_chunks(starting_number, limit, chunk_size) do 
        if starting_number + chunk_size >= limit do
            [{starting_number+1, limit}]
        else
            [{starting_number+1, starting_number + chunk_size} | create_chunks(starting_number+chunk_size, limit, chunk_size)]
        end
    end

    def find_result({{first, last},max_length}) do
        Enum.each first..last, fn first_number ->
            x = get_sum_of_squares(first_number, max_length, 0)
            x = :math.sqrt(x)
            if x==trunc(x) do
                IO.puts(first_number)
            end
        end
    end

    # Recursive function to calculate sum of squares of all integers from x to x+max_length-1
    def get_sum_of_squares(x, 1, accumulator) do x*x+accumulator end
    def get_sum_of_squares(x, max_length, accumulator) do get_sum_of_squares(x+1, max_length-1, accumulator+x*x) end

end

Supersuper.init({1000_000,4})