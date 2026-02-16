defmodule CatBookshop.Solution2 do
  alias CatBookshop.Model, as: M
  alias CatBookshop.Controller, as: C

  @spec handle(map()) :: {:ok, M.Order.t()} | {:error, any()}
  def handle(data) do
    case C.validate_incoming_data(data) do
      {:ok, data} ->
        case C.validate_cat(data["cat"]) do
          {:ok, cat} ->
            case C.validate_address(data["address"]) do
              {:ok, address} ->
                state = %{cat: cat, address: address}
                handle_books(data["books"], state)

              {:error, error} ->
                {:error, error}
            end

          {:error, error} ->
            {:error, error}
        end

      {:error, error} ->
        {:error, error}
    end
  end

  def handle_books(books, state) do
    books
    |> Enum.map(&C.validate_book/1)
    |> Enum.reduce({[], nil}, fn
      {:ok, book}, {books, nil} -> {[book | books], nil}
      {:error, error}, {books, nil} -> {books, {:error, error}}
      _maybe_book, acc -> acc
    end)
    |> case do
      {books, nil} -> {:ok, M.Order.create(state.cat, state.address, books)}
      {_, error} -> error
    end
  end
end
