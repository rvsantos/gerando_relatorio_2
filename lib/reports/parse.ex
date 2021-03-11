defmodule JobReportGenerator.Parse do
  def parse_file(filename) do
    "report/#{filename}"
    |> File.stream!()
    |> Stream.map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
  end
end
