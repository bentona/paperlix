defmodule Paperlix.Cli do

  def main(args) do
    [command] = args
    res = case command do
      "start" -> Paperlix.Client.start()
      "stop" -> Paperlix.Client.stop()
      "status" -> Paperlix.Client.status()
    end
    IO.puts(res)
  end

end
