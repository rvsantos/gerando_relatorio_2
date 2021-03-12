defmodule JobReportGenerator.HoursPerYear do
  alias JobReportGenerator.AllHours

  def build(content) do
    years =
      content
      |> Enum.map(fn [_name, _hour, _day, _mounth, year] -> year end)
      |> Enum.uniq()

    names_with_hours_per_years =
      content
      |> AllHours.list_of_names()
      |> report_acc(years)

    hours_per_year =
      content
      |> Enum.reduce(names_with_hours_per_years, fn line, report -> sum_hours(line, report) end)

    hours_per_year
  end

  defp report_acc(list, years) do
    list
    |> Enum.into(%{}, fn x -> {x, Enum.into(years, %{}, &{&1, 0})} end)
  end

  defp sum_hours([name, hour, _day, _mounth, year], report) do
    hours_per_year = Map.put(report[name], year, report[name][year] + hour)
    %{report | name => hours_per_year}
  end
end
