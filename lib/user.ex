defmodule User do

  defstruct name: nil, email: nil

  def new(name, email) do
    new_user = %__MODULE__{name: name, email: email}
    {:ok, new_user}
  end
end