defmodule MySpawn do
  def my_spawn(mod, func, args) do
    spawn(fn ->
      start_time = System.system_time(:millisecond)

      try do
        apply(mod, func, args)
      rescue
        error ->
          duration = System.system_time(:millisecond) - start_time
          IO.puts("Process died due to: #{inspect(error)}")
          IO.puts("Duration: #{duration} milliseconds")
      end
    end)
  end
end

defmodule MySpawnWithTimeout do
  def my_spawn(mod, func, args, time) do
    spawn(fn ->
      Process.send_after(self(), :kill, trunc(time * 1000))
      apply(mod, func, args)
    end)

    receive do
      :kill ->
        Process.exit(self(), :normal)
    end
  end
end

defmodule RegisteredProcess do
  def start do
    pid = spawn_link(fn -> loop() end)
    Process.register(pid, :registered_process)
  end

  def loop do
    receive do
      :stop ->
        exit(:normal)
    after
      5000 ->
        IO.puts("I'm still running")
        loop()
    end
  end

  def monitor do
    spawn(fn ->
      Process.monitor(:registered_process)
      receive do
        {:DOWN, _ref, :process, :registered_process, _reason} ->
          IO.puts("Registered process died, restarting...")
          RegisteredProcess.start()
      end
    end)
  end
end

defmodule WorkerManager do
  def start_workers(worker_count) do
    Enum.map(1..worker_count, fn _ -> start_worker() end)
  end

  def start_worker do
    worker_pid = spawn_link(fn -> worker_loop() end)
    Process.monitor(worker_pid)
  end

  def worker_loop do
  end

  def monitor do
    receive do
      {:DOWN, _ref, :process, pid, _reason} ->
        IO.puts("Worker #{inspect(pid)} died, restarting...")
        start_worker()
        monitor()
    end
  end
end

defmodule RestartAllManager do
  def start_workers(worker_count) do
    Enum.map(1..worker_count, fn _ -> start_worker() end)
  end

  def start_worker do
    worker_pid = spawn_link(fn -> worker_loop() end)
    Process.monitor(worker_pid)
  end

  def worker_loop do
  end

  def monitor(pids) do
    receive do
      {:DOWN, _ref, :process, pid, _reason} ->
        IO.puts("Worker #{inspect(pid)} died, restarting all...")
        new_pids = start_workers(length(pids))
        monitor(new_pids)
    end
  end
end

defmodule SpawnLinkExample do
  def start do
    parent_pid = self()
    spawn_link(fn ->
      send(parent_pid, {:msg, "Child Process"})
      exit(:normal)
    end)

    :timer.sleep(500)
    receive_messages()
  end

  def run do
    start()
  end

  def receive_messages do
    receive do
      {:msg, message} ->
        IO.puts("Received: #{message}")
        receive_messages()
    after
      500 ->
        IO.puts("Empty.")
    end
  end
end
