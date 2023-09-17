defmodule NimbleJsonTest do
  use ExUnit.Case
  doctest NimbleJson

  test "greets the world" do
    assert NimbleJson.hello() == :world
  end
end
