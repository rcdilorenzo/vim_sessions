defmodule VimSessions.Render do
  import Plug.Conn
  import Phoenix.Controller, except: [action: 2]
  import String

  def created(conn, map) do
    put_status(conn, 201) |> json map
  end

  def ok(conn) do
    json conn, %{success: true}
  end

  def json_entity(conn, nil), do: not_found(conn, "Not found", false)
  def json_entity(conn, obj), do: json(conn, obj)

  def not_found(conn, msg \\ "Not found", should_halt \\ true) do
    conn = put_status(conn, 404) |> json(%{success: false, error: msg})
    if(should_halt, do: halt(conn), else: conn)
  end

  def bad_request(conn, msg \\ "Bad request") do
    put_status(conn, 400) |> json(%{success: false, error: msg}) |> halt
  end

  def put_errors(conn, %Ecto.Changeset{valid?: false, errors: errors, validations: validations}) do
    put_status(conn, 400) |> json %{success: false, errors: errors |> Enum.map(fn ({key, value}) ->
        error_description(key, value, validations)
    end) |> Enum.reverse}
  end

  def get_errors(%Ecto.Changeset{valid?: false, errors: errors, validations: validations}) do
    errors |> Enum.map(fn ({key, value}) ->
        error_description(key, value, validations)
    end) |> Enum.reverse
  end

  defp error_description(key, :required, _), do: "#{capitalize Atom.to_string key} is required."
  defp error_description(key, value, validations) when is_list(validations) do
    Enum.find_value validations, "#{capitalize Atom.to_string key} is invalid.", fn
      ({key, {k, v}}) ->
        "#{capitalize Atom.to_string key} #{v}"

      ({key, specific_validations}) when is_list(specific_validations) ->
        Enum.find_value specific_validations, fn ({k, v}) ->
          if k == value, do: "#{capitalize Atom.to_string key} #{v}"
        end

      ({_, _}) -> nil
    end
  end

  def put_errors(conn, errors) when is_map(errors) do
    put_status(conn, 400) |> json %{errors: errors |> Enum.map(fn ({key, key_errors}) ->
        key_errors = case key_errors do
          [[_]] -> key_errors |> Enum.map &(Dict.values(&1) |> List.first)
          _ -> key_errors
        end
        capitalize(Atom.to_string(key)) <> " " <> Enum.join(key_errors, ", ") <> "."
    end) |> Enum.reverse, success: false}
  end

  def decode_ids(conn, _opts) do
    params = conn.params |> Enum.map(fn ({k, v}) ->
      cond do
        ends_with?(k, "id") && is_binary(v) -> {k, to_integer v}
        true -> {k, v}
      end
    end) |> Enum.into %{}
    conn |> struct %{params: params}
  end

end
