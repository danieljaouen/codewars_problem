defmodule Challenge do
  def solution(lst) do
    lst =
      if is_binary(lst) do
        String.to_charlist(lst)
      else
        lst
      end

    table = :ets.new(:table, [:set, :protected])
    :ets.insert(table, {"prev", ""})
    :ets.insert(table, {"result", []})

    Enum.each(lst, fn item ->
      prev = :ets.lookup(table, "prev") |> Enum.at(0) |> elem(1)
      result = :ets.lookup(table, "result") |> Enum.at(0) |> elem(1)

      if prev != item do
        :ets.insert(table, {"prev", item})
        :ets.insert(table, {"result", [item | result]})
      end
    end)

    result = :ets.lookup(table, "result") |> Enum.at(0) |> elem(1) |> Enum.reverse()
    result = "#{result}" |> String.split("", trim: true)

    :ets.delete(table)

    result
  end
end

IO.inspect(Challenge.solution(["A", "A", "A", "B", "B", "C", "A", "A", "D", "E", "E", "E", "E"]))
IO.inspect(Challenge.solution("AAABBCAADEEEE"))
