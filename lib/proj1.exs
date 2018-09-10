# Reads arguments from cmd and passes them to SumOfSquares module
{limit, max_length} = List.to_tuple(System.argv)
SumOfSquares.init {1, String.to_integer(limit), String.to_integer(max_length)}