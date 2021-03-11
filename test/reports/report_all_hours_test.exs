defmodule JobReportGenerator.AllHoursTest do
  use ExUnit.Case

  alias JobReportGenerator.AllHours

  describe "build/1" do
    test "build all_hours reports" do
      response =
        "report_test.csv"
        |> AllHours.build()

      expected_response = %{
        "Cleiton" => 12,
        "Daniele" => 21,
        "Danilo" => 7,
        "Diego" => 12,
        "Giuliano" => 14,
        "Jakeliny" => 22,
        "Joseph" => 13,
        "Mayk" => 19,
        "Rafael" => 7
      }

      assert response == expected_response
    end
  end
end
