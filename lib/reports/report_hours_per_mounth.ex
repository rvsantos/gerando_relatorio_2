defmodule JobReportGenerator.HoursPerMounth do
  alias JobReportGenerator.AllHours

  @mounths %{
    "1" => "janeiro",
    "2" => "fevereiro",
    "3" => "março",
    "4" => "abril",
    "5" => "maio",
    "6" => "junho",
    "7" => "julho",
    "8" => "agosto",
    "9" => "setembro",
    "10" => "outubro",
    "11" => "novembro",
    "12" => "dezembro"
  }

  def build(content) do
    mounths =
      content
      |> Enum.map(fn [_name, _hour, _day, mounth, _year] -> mounth end)
      |> Enum.uniq()

    names =
      content
      |> AllHours.list_of_names()
      |> report_acc(mounths)

    hours_per_mounth =
      content
      |> Enum.reduce(names, fn line, report -> sum_values(line, report) end)
      |> insert_months_name()

    hours_per_mounth
  end

  defp report_acc(list, mounths) do
    list
    |> Enum.into(%{}, fn x -> {x, Enum.into(mounths, %{}, &{&1, 0})} end)
  end

  defp sum_values([name, hours, _day, mounth, _year], report) do
    list_of_mounths = Map.put(report[name], mounth, report[name][mounth] + hours)
    %{report | name => list_of_mounths}
  end

  defp insert_months_name(list) do
    list
    |> Enum.reduce(%{}, fn {name, mounths}, report ->
      list_months_name =
        mounths
        |> Enum.reduce(%{}, fn {k, v}, acc -> Map.put(acc, @mounths[k], v) end)

      Map.put(report, name, list_months_name)
    end)
  end
end
