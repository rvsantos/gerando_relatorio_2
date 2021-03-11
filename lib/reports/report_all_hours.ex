defmodule JobReportGenerator.AllHours do
  alias JobReportGenerator.Parse

  def build(filename) do
    content =
      filename
      |> Parse.parse_file()

    names =
      content
      |> list_of_names

    all_hours =
      content
      |> Enum.reduce(report_acc(names), &sum_hours(&1, &2))

    all_hours
  end

  defp list_of_names(list) do
    list
    |> Enum.map(fn [head | _tail] -> head end)
    |> Enum.uniq()
  end

  defp sum_hours([name, hour | _tail], report) do
    Map.put(report, name, report[name] + hour)
  end

  defp report_acc(names), do: Enum.into(names, %{}, fn line -> {line, 0} end)
end
