defmodule JobReportGenerator do
  alias JobReportGenerator.Parse
  alias JobReportGenerator.AllHours
  alias JobReportGenerator.HoursPerMounth
  alias JobReportGenerator.HoursPerYear

  def build(filename) do
    content =
      filename
      |> Parse.parse_file()

    all_hours =
      content
      |> AllHours.build()

    hours_per_mounth =
      content
      |> HoursPerMounth.build()

    hours_per_year =
      content
      |> HoursPerYear.build()

    %{all_hours: all_hours, hours_per_mount: hours_per_mounth, hours_per_year: hours_per_year}
  end
end
