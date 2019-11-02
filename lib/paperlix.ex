defmodule Paperlix.CLI do

  def status do
    case get_machine() do
      {200, %{state: state}} -> state
      error -> error
    end
  end
  
  def main(args) do
    [command] = args
    res = case command do
      "start" -> start()
      "stop" -> stop()
      "status" -> status()
    end
    IO.puts(res)
  end
  
  def get_machines do
    get('/machines/getMachines')
  end

  def get_machine do
    get("/machines/getMachinePublic?machineId=#{id()}")
  end

  def stop do
    post("/machines/#{id()}/stop")
  end

  def start do
    post("/machines/#{id()}/start")
  end

  def post(path) do
    case HTTPoison.post(format_url(path), '', headers()) do
      {:ok, %{status_code: code}} -> code
      {:error, %{reason: reason}} -> {:error, reason}
    end
  end

  def format_url(path) do
    "https://api.paperspace.io#{path}"
  end

  def get(path) do
    case HTTPoison.get(format_url(path), headers()) do
      {:ok, %{body: raw_body, status_code: code}} -> {code, parse(raw_body)}
      {:error, %{reason: reason}} -> {:error, reason}
    end
  end

  def parse(response) do
    case Poison.decode(response, keys: :atoms) do
      {:ok, decoded} -> decoded
      {:error, error} -> {:error, error}
    end
  end

  def id do
    Application.get_env(:paperlix, :machine_id)
  end

  def headers do
    ["x-api-key": Application.get_env(:paperlix, :api_key)]
  end

end

