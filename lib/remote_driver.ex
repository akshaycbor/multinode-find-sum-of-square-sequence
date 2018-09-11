defmodule RemoteDriver do

    @doc """
    Accepts start_number, last_number and max_length of the sequence as a tuple and a list of nodes to distribute work
    Distributes the workload equally among all nodes and starts up the remote processes
    """
    def init({first_number,last_number,max_length}, nodes) do
        Enum.each nodes, fn node ->
            Node.connect(node)
        end
        
        chunk_size = div(last_number, length(nodes))+1
        spawn_nodes(nodes, first_number, last_number, chunk_size, max_length)
    end

    @doc """
    Starts remote process and passes the respective work unit to each node on the provided node list
    """
    def spawn_nodes([head_node|nodes], first_number, last_number, chunk_size, max_length) do
        if first_number+chunk_size < last_number do
            Node.spawn_link(head_node, SumOfSquares, :init, [{first_number, first_number+chunk_size, max_length}])
            spawn_nodes(nodes, first_number+chunk_size+1, last_number, chunk_size, max_length)
        else
            Node.spawn_link(head_node, SumOfSquares, :init, [{first_number, last_number, max_length}])
        end
    end
end