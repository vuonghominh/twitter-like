defmodule App.Guardian do
  use Guardian, otp_app: :app
  alias Api.User.Service, as: User

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = User.get_user_by_id(id)
    {:ok,  resource}
  end
end