defmodule JobReportGenerator do
  alias JobReportGenerator.Parse
  alias JobReportGenerator.AllHours
  alias JobReportGenerator.HoursPerMounth

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

    %{all_hours: all_hours, hours_per_mount: hours_per_mounth}
  end
end
