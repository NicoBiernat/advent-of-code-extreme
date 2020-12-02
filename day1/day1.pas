program day1;

{$GOTO ON}
{$mode objFPC}

uses Sysutils;

const
    FILENAME = 'input.txt';
    BUFFER_SIZE = 200;
    WANTED_VALUE = 2020;

var
    fileIn : TextFile;
    input_length : integer;
    inputString : string;
    input : Array[0..BUFFER_SIZE-1] of Integer;
    solution_one, solution_two : integer;

function part_one(const input: Array of integer; const length : integer) : integer;
label done;
var i, j: integer;
begin
    for i := 0 to length-1 do
        for j := 0 to length-1 do
            if (input[i] + input[j] = WANTED_VALUE) then
                goto done;
done:
    result := input[i] * input[j];
end;

function part_two(const input: Array of integer; const length : integer) : integer;
label done;
var i, j, k : integer;
begin
    for i := 0 to length-1 do
        for j := 0 to length-1 do
            for k := 0 to length-1 do
                if (input[i] + input[j] + input[k] = WANTED_VALUE) then
                    goto done;
done:
    part_two := input[i] * input[j] * input[k];
end;

begin
    input_length := 0;
    AssignFile(fileIn, FILENAME);
    try
        try
            reset(fileIn);
            while not eof(fileIn) do
            begin
                readln(fileIn, inputString);
                input[input_length] := StrToInt(inputString);
                inc(input_length);
            end;
        except
            on E: Exception do
                writeln('Error while handling file: ', E.Message)
        end;
    finally
        CloseFile(fileIn);
    end;
    if (input_length <= BUFFER_SIZE) then
    begin
        solution_one := part_one(input, input_length);
        solution_two := part_two(input, input_length);
        writeln('Solution 1: ', solution_one);
        writeln('Solution 2: ', solution_two);
    end
    else
        writeln('Buffer Overflow Detected - Aborting: Please provide an input file with at most 200 numbers in separate lines');
end.