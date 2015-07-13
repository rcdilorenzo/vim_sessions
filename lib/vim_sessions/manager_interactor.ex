defmodule VimSessions.ManagerInteractor do
  use Addict.BaseManagerInteractor

  def create(user_params, repo \\ Addict.Repository, mailer \\ Addict.EmailGateway, password_interactor \\ Addict.PasswordInteractor) do
    validate_params(user_params)
      |> (fn (params) -> params["password"] end).()
      |> password_interactor.generate_hash
      |> create_username(user_params, repo)
  end

  defp create_username(hash, user_params, repo) do
    user_params = Map.delete(user_params, "password")
      |> Map.put("hash", hash)
    repo.create(user_params)
  end
end
