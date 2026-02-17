# Эта функция нужна для того, чтобы результат из одной функции передавался
# входным значением во вторую через оператор |>. А если на каком-то шаге цепочки
# возникает ошибка, то дальше она не идет

defmodule FP do

#@spec bind(m_fun(), m_fun()) :: m_fun()
  def bind(f1, f2) do
    fn args ->
      case f1.(args) do
        {:ok, result} -> f2.(result)
        {:error, error} -> {:error, error}
      end
    end
  end

  # Примеры использования:
  # f1 |> f2 |> f3 |> f4

  def try_bind do
    f = bind(&f1/1, &f2/1) |> bind(&f3/1) |> bind(&f4/1)
    # a |> f1 >>= f2 >>= f3 >>= f4
    f.(7)
  end

  #Вывод: {:ok, 1118} или {:error, :something_wrong}

  def f1(a) do
    {:ok, a + 1}
  end

  def f2(_a) do
    #{:ok, a + 10}
    {:error, :something_wrong}
  end

  def f3(a) do
    {:ok, a + 100}
  end

  def f4(a) do
    {:ok, a + 1000}
  end
end
