alias Mgr.OCV.Distributed.{Assigner, Detector}

unless Node.alive?() do
  {:ok, _pid} = Node.start(:"n#{Enum.random(1..1_000_000)}", :shortnames)
end

master_node = :"master@MacBook-Pro-MatHek"
true = Node.connect(master_node)
true = Node.monitor(master_node, true)
{:ok, detector} = Detector.start_link()
:ok = Assigner.register({Assigner, master_node}, detector)

receive do
  _ -> :ok
end
