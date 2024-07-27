defmodule Keyout do
  @moduledoc """
  Documentation for `Keyout`.
  """

  def key() do
    1..10
    |> Enum.each(fn _ -> send_key() end)
  end

  def send_key() do
    System.cmd("xdotool", ["type", "a"])
    Process.sleep(1000)
  end
end
