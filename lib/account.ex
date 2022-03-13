defmodule Account do
  defstruct user: User, funds: nil

  @filename 'accounts.txt'

  def new(user) do
    accounts = find_accounts()
    cond do
      find_by_email(accounts) ->
        {:error, "User already exists"}
      true -> 
        new_account = %__MODULE__{user: user, funds: 1000}
        binary =  accounts ++ [new_account]
        |> :erlang.term_to_binary()
        File.write(@filename, binary)
        new_account
    end
  end
  
  def find_accounts do
   {:ok, binary} = File.read(@filename)
   :erlang.binary_to_term binary
  end

  def find_by_email(email), do: Enum.find(find_accounts(), &(&1.user.email == email))

  def transfer(from, to, amount) do
    from = find_by_email(from.user.email)
    cond do
      is_not_available_funds(from.funds, amount) -> {:error, "Insufficient funds"}
      true -> 
        to = find_by_email(to.user.email)
        from = %Account{ from | funds: from.funds - amount }
        to = %Account{ to |  funds: to.funds + amount }
        {from, to}
    end

    # IO.puts "Transferindo #{amount} Reais de #{from.user.name} para #{to.user.name}"
    # IO.inspect to
    # IO.inspect from
  end

  def withdraw_funds(account, amount) do
    cond do
      is_not_available_funds(account.funds, amount) -> {:error, "Insufficient funds"}
      true ->
        account = %Account{ account | funds: account.funds - amount }
        {:ok, account}
    end
  end

  defp is_not_available_funds(funds, amount), do: funds < amount
end