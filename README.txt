Group Info: 
Akshay Borgharkar : 19041904
Aastha Jhunjhanuwala : 55271081

Instructions: 
1.  Navigate to project(/../sum_of_squares/)
2.  Run command : mix run lib/proj1.exs n k
        eg. mix run lib/proj1.exs 1000000 4

P.S: Please make sure to compile using "mix compile" before calculating the process execution time as the compilation adds on a few seconds

Sample Input & Output:
mix run lib/proj1.exs 40 24
1
9
25
20

Note: Output is not sorted


Project Answers:

1.  Work unit : 1000
    The work unit distribution was determined on the basis of trial and error. This distribution gave the highest performance.

2.  Result for the 10^6,4 is empty

3.  CPU/Real time ratio:
    time mix run lib/proj1.exs 1000000 4 : 
    real   0m4.129s
    user   0m4.281s
    sys    0m2.469s
    Ratio - 1.635

4.  Largest Problem executed : 10^9, 24
    real    11m8.341s
    user    43m32.016s
    sys     0m12.500s
    Ratio - 3.927


Remote execution Instructions:
1.  Start all the nodes within the project by - 
    iex --name name@YourIP --cookie foo -S mix

2.  Ensure other remote nodes can be connected to by Node.connect(:"remotenode@remotehost")

3.  Run RemoteDriver.init({1, n, k}, Node.list())
        eg. RemoteDriver.init({1, 100000, 24}, Node.list())

Requirements : A  copy of the code should be available at the remote nodes

No. of machines : 3 (We didn't have anymore available)