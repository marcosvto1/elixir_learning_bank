defmodule AccountTest do
  use ExUnit.Case

  doctest Account

  setup do
    File.write("accounts.text", :erlang.term_to_binary([]))

    on_exit(fn -> 
      File.rm("accounts")
    end)
  end

  describe "CreateAccount" do
    test "Should create an new account" do
      {_, user} = User.new("Marcos", "marcosvto1@gmail.com")
      assert Account.new(user) == %Account{user: user, funds: 1000}
    end
  end

  describe "CreateTransfer" do
    test "Should make an transfer 10 " do
      {_, user} = User.new("Marcos", "marcosvto1@gmail.com")
      account_1 = Account.new(user)

      {_, user2} = User.new("Pedro", "pedro@mail.com")
      account_2 = Account.new(user2)

      {from, to } =  Account.transfer(account_1, account_2, 10)
      assert from.funds == 990
      assert to.funds == 1010
    end

    test "Should return erro when is Insufficient funds" do
      {_, user} = User.new("Marcos", "marcosvto1@gmail.com")
      account_1 = Account.new(user)

      {_, user2} = User.new("Pedro", "pedro@mail.com")
      account_2 = Account.new(user2)

      assert Account.transfer(account_1, account_2, 1001) == {:error, "Insufficient funds"}
    end

  end

  describe "WithdrawFunds" do
    test "should returns :ok and account with new funds" do
      {_, user} = User.new("Marcos", "marcosvto1@gmail.com")
      account = Account.new(user)

      assert Account.withdraw_funds(account, 10) == {:ok, %Account{user: user, funds: 990 }}
    end
  end
end