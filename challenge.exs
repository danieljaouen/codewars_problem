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
      prev = fetch(table, "prev")
      result = fetch(table, "result")

      if prev != item do
        :ets.insert(table, {"prev", item})
        :ets.insert(table, {"result", [item | result]})
      end
    end)

    result = fetch(table, "result") |> Enum.reverse()
    result = "#{result}" |> String.split("", trim: true)

    :ets.delete(table)

    result
  end

  defp fetch(table, key) do
    :ets.lookup(table, key) |> Enum.at(0) |> elem(1)
  end

  def solution_without_ets(lst) do
    lst =
      if is_binary(lst) do
        String.split(lst, "", trim: true)
      else
        lst
      end

    Enum.with_index(lst, fn item, index ->
      if index == 0 do
        item
      else
        prev = Enum.at(lst, index - 1)

        if prev != item do
          item
        end
      end
    end)
    |> Enum.filter(&(&1 != nil))
  end
end

IO.inspect(Challenge.solution(["A", "A", "A", "B", "B", "C", "A", "A", "D", "E", "E", "E", "E"]))
IO.inspect(Challenge.solution("AAABBCAADEEEE"))

IO.inspect(
  Challenge.solution_without_ets(["A", "A", "A", "B", "B", "C", "A", "A", "D", "E", "E", "E", "E"])
)

IO.inspect(Challenge.solution_without_ets("AAABBCAADEEEE"))
