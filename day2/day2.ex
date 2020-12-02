defmodule Day2 do
    def main(_ \\ []) do
        mainProc = self()
        counter = spawn fn -> validCounter(1, mainProc, 0) end
        counter2 = spawn fn -> validCounter(2, mainProc, 0) end
        checker = spawn fn -> passwordChecker(counter) end
        checker2 = spawn fn -> passwordChecker2(counter2) end
        fOut = spawn fn -> fanOut([checker, checker2]) end
        parser = spawn fn -> lineParser(fOut) end
        spawn fn -> lineReader("input.txt", parser) end
        receive do
            {:result, 1, result} ->
                IO.puts "Solution 1:"
                IO.inspect result
        end
        receive do
            {:result, 2, result} ->
                IO.puts "Solution 2:"
                IO.inspect result
        end
        :ok
    end

    def lineReader(filePath, next) do
        file = File.open!(filePath)
        readUntilEOF(file, next)
    end

    def readUntilEOF(file, next) do
        line = IO.gets(file, "")
        case line do
            :eof ->
                send next, :eof
            _ ->
                lineStripped = String.replace(line, "\n", "")
                send next, {:next, lineStripped}
                readUntilEOF(file, next)
            end

    end

    def lineParser(next) do
        receive do
            :eof -> send next, :eof
            {:next, line} ->
                [amnt, char, password] = String.split(line, " ")
                [amountLow, amountHigh] = String.split(amnt, "-")
                letter = String.replace(char, ":", "")
                send next, {:next, elem(Integer.parse(amountLow), 0), elem(Integer.parse(amountHigh), 0), letter, password}
                lineParser(next)
            _ -> IO.puts "lineParser: wrong message"
        end
    end

    def passwordChecker(next) do
        receive do
            :eof -> send next, :eof
            {:next, low, high, char, password} ->
                isValid = password
                    |> String.graphemes
                    |> Enum.count(& &1 == char)
                    |> (&(low <= &1 and &1 <= high)).()
                send next, {:next, isValid}
                passwordChecker(next)
            _ -> IO.puts "passwordChecker: wrong message"
        end
    end

    def passwordChecker2(next) do
        xor = fn(a, b) ->
            (a || b) && !(a && b)
        end
        receive do
            :eof -> send next, :eof
            {:next, first, second, char, password} ->
                firstChar = String.at(password, first-1)
                secondChar = String.at(password, second-1)
                isValid = xor.(char == firstChar, char == secondChar)
                send next, {:next, isValid}
                passwordChecker2(next)
            _ -> IO.puts "passwordChecker: wrong message"
        end
    end

    def validCounter(n, next, state) do
        receive do
            :eof -> send next, {:result, n, state}
            {:next, isValid} ->
                if isValid do
                    validCounter(n, next, state + 1)
                else
                    validCounter(n, next, state)
                end
            _ -> IO.puts "validCounter: wrong message"
        end
    end

    def fanOut(processes) do
        receive do
            :eof ->
                Enum.map(processes, fn x ->
                    send x, :eof
                    x
                end)
            msg ->
                Enum.map(processes, fn x ->
                    send x, msg
                    x
                end)
                fanOut(processes)
        end
    end
end
