defmodule DdjKeyout do
  @moduledoc """
  Documentation for `Keyout`.
  """

  @doc """

  """
  def main() do
    {:ok, input} = PortMidi.open(:input, "DDJ-FLX4 MIDI 1")
    PortMidi.listen(input, self())
    midi_in(input)

    PortMidi.close(:output, input)
  end

  def midi_in(input) do
    receive do
      {^input, [{{144, 11, 0}, _}]} ->
        IO.inspect("end")

      {^input, [{{151, 4, 0}, _}]} ->
        send_key("a", input)

      {^input, [{{151, 5, 0}, _}]} ->
        send_key("b", input)

      {^input, [{{151, 6, 0}, _}]} ->
        send_key("c", input)

      {^input, [{{151, 7, 0}, _}]} ->
        send_key("d", input)

      a ->
        IO.inspect(a)
        midi_in(input)
    end
  end

  def send_key(key, input) do
    System.cmd("xdotool", ["type", key])
    midi_in(input)
  end
end
