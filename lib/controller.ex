defmodule CatBookshop.Controller do

  alias CatBookshop.Model.Model, as: M
  def handle(request) do

  end

  @spec validate_incoming_data(map()) :: {:ok, map()} | {:error, :invalid_incoming_data}
  def validate_incoming_data(data) do
    if rand_success() do
      {:ok, data}
    else
      {:error, :invalid_incoming_data}
    end
  end

  @spec validate_cat(name :: String.t()) :: {:ok, Cat.t()} | {:error, :cat_not_found}
  def validate_cat(name) do
    if rand_success() do
      {:ok, %M.Cat{id: name, name: name}}
    else
      {:error, :cat_not_found}
    end
  end

  @spec validate_address(String.t()) :: {:ok, Address.t()} | {:error, :invalid_address}
  def validate_address(data) do
    if rand_success() do
      {:ok, %M.Address{other: data}}
    else
      {:error, :invalid_address}
    end
  end

  @spec validate_book(map()) :: {:ok, Book.t()} | {:error, :book_not_found}
  def validate_book(%{"author" => author} = data) do
    if rand_success() do
      {:ok, %M.Book{title: data["title"], author: data["author"]}}
    else
      {:error, :book_not_found}
    end
  end

  def rand_success do
    Enum.random(1..10) > 1
  end
end
