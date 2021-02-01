defmodule Fpmatters do
  @spec fp_sum(list(number())) :: number()
  def fp_sum(list) do
    case list do
      [] ->
        0

      [h | t] ->
        h + fp_sum(t)
    end
  end

  def fp_map([], _), do: []

  def fp_map([h | t], f), do: [f.(h) | fp_map(t, f)]

  @spec gp_sum(list(number())) :: number()
  def gp_sum([]), do: 0

  def gp_sum([h | t]), do: h + gp_sum(t)

  @spec foldr((any(), any() -> any()), any(), list(any())) :: any()
  def foldr(_, x, []), do: x

  def foldr(f, x, [h | t]), do: f.(h, foldr(f, x, t))

  @spec cons(any()) :: list(any())
  def cons(a, list \\ []), do: [a | list]

  @spec append(list(any()), list(any())) :: list(any())
  def append(a, b), do: foldr(&Fpmatters.cons/2, b, a)

  @spec product(list(number())) :: number()
  def product(list), do: foldr(&(&1 * &2), 1, list)

  @spec sum(list(number())) :: number()
  def sum(list), do: foldr(&(&1 + &2), 0, list)

  @spec doubleall(list(number())) :: number()
  def doubleall(list), do: foldr(fn x, y -> [2 * x | y] end, [], list)

  @spec count(any(), number()) :: number()
  def count(_, n), do: n + 1

  @spec len(list(any())) :: number()
  def len(list), do: foldr(&Fpmatters.count/2, 0, list)

  @spec comp((any() -> any()), (any() -> any()), any()) :: any()
  def comp(f, g, x), do: x |> g.() |> f.()

  @spec map(list(any()), (any() -> any())) :: list(any())
  def map(list, f), do: foldr(&Fpmatters.cons(f.(&1), &2), [], list)

  @spec summatrix(list(list(number()))) :: number()
  def summatrix(list), do: list |> Fpmatters.map(&Fpmatters.sum/1) |> Fpmatters.sum()
end
