defmodule Conduit.AccountsTest do
  use Conduit.DataCase

  alias Conduit.Accounts
  alias Conduit.Accounts.Projections.User

  describe "register user" do
    @tag :integration
    test "should succeed with valid data" do
      assert {:ok, %User{} = user} = Accounts.register_user(build(:user))

      assert user.email == "jake@jake.jake"
      assert user.username == "jake"
      assert user.hashed_password == "jakejake"
    end

    @tag :integration
    test "should fail with invalid data and return error" do
      assert {:error, :validation_failure, errors} =
               Accounts.register_user(build(:user, username: ""))

      assert errors == %{username: ["can't be empty"]}
    end

    @tag :integration
    test "should fail when username already taken and return error" do
      assert {:ok, %User{}} = Accounts.register_user(build(:user))
      assert {:error, :validation_failure, errors} = Accounts.register_user(build(:user))

      assert errors == %{username: ["has already been taken"]}
    end

    @tag :integration
    test "should fail when registering identical username at same time and return error" do
      1..2
      |> Enum.map(fn _ -> Task.async(fn -> Accounts.register_user(build(:user)) end) end)
      |> Enum.map(&Task.await/1)
    end
  end
end