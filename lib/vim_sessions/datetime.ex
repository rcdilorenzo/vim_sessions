defmodule VimSessions.DateTime do

  def local do
    {:ok, datetime} = Ecto.DateTime.load timestamp_tuple_with_usec
    datetime
  end

  def timestamp_tuple_with_usec do
    erl_timestamp = :os.timestamp
    {_, _, usec} = erl_timestamp
    {date, {h, m, s}} = :calendar.now_to_datetime(erl_timestamp)
    {date, {h, m, s, usec}}
  end

end
