defmodule CatBookshopTest do
  use ExUnit.Case
  doctest CatBookshop

  test "greets the world" do
    assert CatBookshop.hello() == :world
  end
end
