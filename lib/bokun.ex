defmodule Bokun do

  @moduledoc """
  An HTTP client for Bokun.
  """

  # Let's build on top of HTTPoison
  use Application
  use Tesla

  plug Tesla.Middleware.BaseUrl,  Application.get_env(:bokun, :api_url) || "http://api.bokundemo.com"
  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.DebugLogger

  adapter Tesla.Adapter.Hackney

  def start(_type, _args) do
    Bokun.Supervisor.start_link
  end

  def post_request(endpoint, body \\ %{}, params \\ %{}) do
    headers = parse_headers("POST", endpoint, params)
    Bokun.post(endpoint, body,  query: params, headers: headers)
  end

  def get_request(endpoint, params \\ %{}) do
    headers = parse_headers("GET", endpoint, params)
    Bokun.get(endpoint, query: params, headers: headers)
  end

  def access_key do
    Application.get_env(:bokun, :access_key)
  end

  def secret_key do
    Application.get_env(:bokun, :secret_key)
  end

  defp parse_headers(method, endpoint, params) do
    current_time = Timex.format!(Timex.now, "%F %T", :strftime)
    %{
      "Content-Type": "application/json",
      "Accept": "application/json",
      "X-Bokun-AccessKey": access_key,
      "X-Bokun-Date": current_time,
      "X-Bokun-Signature": get_signature(method, endpoint, params, current_time)
    }
  end

  defp get_signature(method, endpoint, params, current_time) do
    concatened_string = get_unscrypted_signature(method, endpoint, params, current_time)
    :crypto.hmac(:sha, secret_key, concatened_string)
    |> Base.encode64
  end

  defp get_unscrypted_signature(method, endpoint, params, current_time) do
    current_time <> access_key <> method <> parse_path(endpoint, params)
  end

  def parse_path(url, %{}) do
    url
  end

  def parse_path(url, params) do
    url <> "?" <> URI.encode_query(params)
  end
end
