defmodule CatBookshop.Solution3 do
  alias CatBookshop.Model, as: M
  alias CatBookshop.Errors, as: E
  alias CatBookshop.Controller, as: C

  require Logger

  @spec handle(map()) :: {:ok, M.Order.t()} | {:error, any()}
  def handle(data) do
    try do
      data = C.validate_incoming_data!(data)

      %{
        "cat" => cat_name,
        "address" => address_str,
        "books" => book_data
      } = data

      cat = C.validate_cat!(cat_name)
      address = C.validate_address!(address_str)

      books =
        Enum.map(book_data, fn data ->
          C.validate_book!(data)
        end)

      order = M.Order.create(cat, address, books)
      {:ok, order}
    rescue
      e in [E.InvalidIncomingData, E.CatNotFound, E.InvalidAddress, E.BookNotFound] ->
        Logger.error(Exception.message(e))
        {:error, E.description(e)}
        # {:error, Exception.message(e)}
    end
  end
end
