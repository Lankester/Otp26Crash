defmodule Otp26CrashWeb.ErrorJSONTest do
  use Otp26CrashWeb.ConnCase, async: true

  test "renders 404" do
    assert Otp26CrashWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert Otp26CrashWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
