defmodule CatBookshopTest do
  use ExUnit.Case

  test "test data" do
    assert CatBookshop.test_data() == TestData.valid_data()
  end
end
