defmodule Purse do
  defstruct process: -1, store: %{}
end

defmodule Purse.Message do
  defstruct currency: :KGS, amount: 0, link: nil, pid: -1
end

defmodule Purse.API do
  defp listen(store) do
    receive do
      {:deposit, msg} ->
        store = Map.update(store, msg.currency, 0, &(&1 + msg.amount))
        send(msg.pid, {:ok, msg, msg.link})

      {:withdraw, msg} ->
        new_mes = Map.update(store, msg.currency, 0, &(&1 + msg.amount))
        send(msg.pid, {:ok, msg, msg.link})

      {:peek, msg} ->
        IO.inspect(msg)
        send(msg.pid, {:ok, msg, msg.link})

      {:peek_all, msg} ->
        IO.inspect(msg)
        send(msg.pid, {:ok, msg, msg.link})

      {_, msg} ->
        IO.inspect(msg)
        IO.puts("unknown operation")
        send(msg.pid, {:err_not_implemented, msg, msg.link})
    end

    listen(store)
    IO.inspect(store)
  end

  defp listen_wrap() do
    store = %{}
    listen(store)
  end

  def create() do
    pid = spawn_link(fn -> listen_wrap() end)
    pid
  end

  defp listen_for_ref(proc_ref, ref) do
    receive do
      {:ok, ans, ^ref} ->
        IO.inspect(ans)
        :ok

      {_, ans, ^ref} ->
        IO.inspect(ans)
        :error_bad_msg

      _ ->
        IO.puts("not ours")
        listen_for_ref(proc_ref, ref)
    end
  end

  def deposit(purse, currency, amount) do
    case Process.alive?(purse) do
      true ->
        ref = make_ref()
        msg = %Purse.Message{currency: currency, amount: amount, link: ref, pid: self()}
        msg = send(purse, {:deposit, msg})
        proc_ref = Process.monitor(purse)
        listen_for_ref(proc_ref, ref)

      false ->
        :err_proc_is_dead
    end
  end

  def withdraw(purse, currency, amount) do
    case Process.alive?(purse) do
      true ->
        ref = make_ref()
        msg = %Purse.Message{currency: currency, amount: -1 * amount, link: ref, pid: self()}
        msg = send(purse, {:withdraw, msg})
        proc_ref = Process.monitor(purse)

        listen_for_ref(proc_ref, ref)

      false ->
        :err_proc_is_dead
    end
  end

  def peek(purse, currency) do
    case Process.alive?(purse) do
      true ->
        ref = make_ref()
        msg = %Purse.Message{currency: currency, amount: 0, link: ref, pid: self()}
        msg = send(purse, {:peek, msg})
        proc_ref = Process.monitor(purse)

        listen_for_ref(proc_ref, ref)

      false ->
        :err_proc_is_dead
    end
  end

  def peek(purse) do
  end
end

IO.puts("hello, world")
pid = Purse.API.create()

case Purse.API.deposit(pid, :kgs, 1000) do
  :ok -> :ok
  _ -> IO.puts("error")
end
