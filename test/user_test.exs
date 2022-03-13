defmodule UserTest do
  use ExUnit.Case
  doctest User

  describe "CreateUser" do
    test "Should create an new user" do
      assert User.new("Marcos", "marcosvto1@gmail.com") == {:ok, %User{name: "Marcos", email: "marcosvto1@gmail.com"}}
    end
  end
end