defmodule SumOfSquares do
    use Supervisor
    @moduledoc """
    This module accepts M, N and k
    Finds all numbers A such that the sum of squares from A to A+K-1 is itself a perfect square where M<=A<=N 
    """


    @doc """
        Function accepts the start number and the last number with the max length of the required sequences
        Spawns multiple processes to find the sequences for which the condition(described in module doc) holds true
    """
    def init({start_number, last_number, max_length}) do
        children = 
            [
                {Task.Supervisor, name: SquareCalc.TaskSupervisor, restart: :transient}
            ]
        Supervisor.start_link(children, strategy: :one_for_one)

        chunks = create_chunks(start_number-1, last_number, 1000)
        Enum.each chunks, fn chunk ->
            Task.Supervisor.async(SquareCalc.TaskSupervisor, fn -> find_sequences(chunk, max_length) end)
        end
    end

    @doc """
    Accepts the first and the last number of a list and splits the list into sub-lists based on the chunk size passed.
    Result: List of tuples, where each tuple contains the first and last number of the sub-list
    """
    def create_chunks(first_number, last_number, chunk_size) do 
        if first_number + chunk_size >= last_number do
            [{first_number+1, last_number}]
        else
            [{first_number+1, first_number + chunk_size} | create_chunks(first_number+chunk_size, last_number, chunk_size)]
        end
    end

    @doc """
    Accepts a chunk - represented by its first and last number and the max_length of the required sequence
    Prints the first number of each sequence
    """
    def find_sequences({first, last}, max_length) do
        Enum.each first..last, fn first_number ->
            x = get_sum_of_squares(first_number, max_length, 0)
            x = :math.sqrt(x)
            if x==trunc(x) do
                IO.puts("#{first_number}, #{Node.self}")
            end
        end
    end

    # Recursive function to calculate sum of squares of all integers from x to x+max_length-1
    def get_sum_of_squares(x, 1, accumulator) do x*x+accumulator end
    def get_sum_of_squares(x, max_length, accumulator) do get_sum_of_squares(x+1, max_length-1, accumulator+x*x) end

end
