defmodule Rumbl.NewCounter do
  use GenServer

  def inc(pid), do: GenServer.cast(pid, :inc)

  def dec(pid), do: GenServer.cast(pid, :dec)

  def val(pid) do
    GenServer.call(pid, :val)
  end

  def start_link(init_val) do
    GenServer.start_link(__MODULE__, init_val)
  end

  def handle_cast(:inc, val) do
    {:noreply, val + 1}
  end

  def handle_cast(:dec, val) do
    {:noreply, val - 1}
  end

  def handle_call(:val, _from, val) do
    {:reply, val, val}
  end
end
