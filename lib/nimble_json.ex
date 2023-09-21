defmodule NimbleJson.Helpers do
  @moduledoc """
  `NimbleJson.Helpers` is to be imported by the `NimbleJson` module.
  """
  import NimbleParsec, except: [string: 2]

  # string starts
  def character do
    choice([
      utf8_char([{:not, ?"}, {:not, ?\\}]),
      NimbleParsec.string("\\")
      |> choice([
        NimbleParsec.string("\""),
        NimbleParsec.string("\\"),
        NimbleParsec.string("/"),
        NimbleParsec.string("b"),
        NimbleParsec.string("f"),
        NimbleParsec.string("n"),
        NimbleParsec.string("r"),
        NimbleParsec.string("t")
      ])
    ])
    |> tag(:character)
  end

  def string do
    NimbleParsec.string("\"")
    |> repeat(character())
    |> NimbleParsec.string("\"")
    |> tag(:string)
  end

  # string ends

  # whitespace starts
  def space, do: NimbleParsec.string(" ")
  def linefeed, do: NimbleParsec.string("\n")
  def carriage_return, do: NimbleParsec.string("\r")
  def horizontal_tab, do: NimbleParsec.string("\t")

  def whitespace do
    choice([
      space(),
      linefeed(),
      carriage_return(),
      horizontal_tab()
    ])
    |> repeat()
    |> tag(:whitespace)
  end

  # whitespace ends
end

defmodule NimbleJson do
  @moduledoc """
  `NimbleJson` is an attempt to create a simple JSON parser.
  """
  import NimbleParsec, except: [string: 2]
  import NimbleJson.Helpers

  defparsec(:character, character())
  defparsec(:string, string())

  defparsec(:whitespace, whitespace())
end
