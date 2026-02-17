defmodule CatBookshop.Solution5 do
  alias CatBookshop.Controller, as: C
  alias CatBookshop.Solution4, as: S4

  def handle(data) do
    FP.pipeline(data, [
      &C.validate_incoming_data/1,
      &S4.step_validate_cat/1,
      &S4.step_validate_address/1,
      &S4.step_validate_books/1,
      &S4.step_create_order/1
    ])

    # Plug.Conn Phoenix
  end
end
