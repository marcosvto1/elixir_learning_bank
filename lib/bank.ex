defmodule Bank do
  @moduledoc """
  Documentation for `Bank`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Bank.hello()
      :world

  """
  def hello do
    :world
  end

  def start do
    File.write("accounts.txt", :erlang.term_to_binary [])
  end
end
