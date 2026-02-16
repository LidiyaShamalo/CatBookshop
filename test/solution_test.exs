defmodule SolutionTest do
  use ExUnit.Case

  alias CatBookshop.Model, as: M
  alias CatBookshop.Solution1, as: S

  test "create order" do
    valid_data = TestData.valid_data()

    assert S.handle(valid_data) ==
      {:ok,
      %M.Order{
        client: %M.Cat{id: "Tihon", name: "Tihon"},
        address: %M.Address{
          state: nil,
          city: nil,
          other: "Coolcat str 7/42 Minsk Belarus"
        },
        books: [
          %M.Book{
            title: "Distributed systems for fun and profit",
            author: "Mikito Takada"
          },
          %M.Book{title: "Domain Modeling Made Functional", author: "Scott Wlaschin"},
          %M.Book{title: "Удовольствие от Х", author: "Стивен Строгац"}
        ]
      }}
  end
end
