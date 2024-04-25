defmodule LocaleReproTest do
  use ExUnit.Case
  doctest LocaleRepro

  test "greets the world" do
    assert LocaleRepro.hello() == :world
  end
end
