defmodule PaperlixTest do
  use ExUnit.Case
  doctest Paperlix

  test "greets the world" do
    assert Paperlix.hello() == :world
  end
end
