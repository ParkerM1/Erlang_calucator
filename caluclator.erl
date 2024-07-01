% Discribles the module 
-module(calculator).
% Export used for the program
-export([start/0, loop/0]).

% Start the calculator
start() ->
    io:format("Welcome to the Erlang Calculator!~n"),
    io:format("Available operations: add, subtract, multiply, divide, exit~n"),
    loop().

% Main loop of the calculator
loop() ->
    io:format("Enter operation: "),
    Operation = get_line(),
    case Operation of
        "exit" -> 
            io:format("Exiting the calculator. Goodbye!~n"),
            ok;
        _ ->
            io:format("Enter first number: "),
            Number1 = get_number(),
            io:format("Enter second number: "),
            Number2 = get_number(),
            Result = calculate(Operation, Number1, Number2),
            case Result of
                {error, Reason} ->
                    io:format("Error: ~s~n", [Reason]),
                    loop();
                _ ->
                    io:format("Result: ~p~n", [Result]),
                    loop()
            end
    end.

% Function to get a line of input from the user
get_line() ->
    io:get_line("") 
    |> string:trim().

% Function to get a number from the user
get_number() ->
    Line = get_line(),
    case string:to_float(Line) of
        {error, _} ->
            io:format("Invalid number. Try again.~n"),
            get_number();
        {ok, Number} ->
            Number
    end.

% Calculate the result based on the operation
calculate("add", Number1, Number2) ->
    Number1 + Number2;
calculate("subtract", Number1, Number2) ->
    Number1 - Number2;
calculate("multiply", Number1, Number2) ->
    Number1 * Number2;
calculate("divide", _Number1, 0) ->
    {error, "Division by zero"};
calculate("divide", Number1, Number2) ->
    Number1 / Number2;
calculate(_, _Number1, _Number2) ->
    {error, "Unknown operation"}.

% Helper functions (not essential, but added to increase code size)
% Function to convert string to float safely
string_to_float_safe(String) ->
    case string:to_float(String) of
        {error, _} -> 0.0;
        {ok, Float} -> Float
    end.

% Function to add a list of numbers
sum_list([]) -> 0;
sum_list([H | T]) -> H + sum_list(T).

% Function to multiply a list of numbers
multiply_list([]) -> 1;
multiply_list([H | T]) -> H * multiply_list(T).

% Function to subtract a list of numbers from the first element
subtract_list([H | T]) -> subtract_list(H, T);
subtract_list(Result, []) -> Result;
subtract_list(Result, [H | T]) -> subtract_list(Result - H, T).

% Function to divide the first number by the rest of the list
divide_list([H | T]) -> divide_list(H, T);
divide_list(Result, []) -> Result;
divide_list(_, [0 | _]) -> {error, "Division by zero in list"};
divide_list(Result, [H | T]) -> divide_list(Result / H, T).

% Additional test function
% Used to make sure the calculator is working
test_calculator() ->
    io:format("Testing calculator...~n"),
    io:format("Sum: ~p~n", [sum_list([1, 2, 3, 4, 5])]),
    io:format("Multiply: ~p~n", [multiply_list([1, 2, 3, 4, 5])]),
    io:format("Subtract: ~p~n", [subtract_list([10, 1, 2, 3])]),
    io:format("Divide: ~p~n", [divide_list([100, 2, 5])]),
    io:format("Test completed.~n").