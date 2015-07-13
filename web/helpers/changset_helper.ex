defmodule ChangesetHelper do
  def concat_errors(changeset, delimiter \\ ", ") do
    List.foldl changeset.errors, "", fn
      ({key, value}, "") ->
        "#{key} #{value}"
      ({key, value}, string) ->
        "#{string}#{delimiter}#{key} #{value}"
    end
  end
end
