defmodule Bokun do

  @moduledoc """
  An HTTP client for Bokun.
  """

  # Let's build on top of HTTPoison
  use Application
  use HTTPoison.Base
  require IEx

  def start(_type, _args) do
    Bokun.Supervisor.start_link
  end

  def post_request(endpoint, body \\ %{}, params \\ %{}) do
    Bokun.post!(endpoint, Poison.encode!(body), parse_headers("POST", endpoint, params), [params: params])
  end

  def get_request(endpoint, params \\ %{}) do
    header = parse_headers("GET", endpoint, params)
    Bokun.get!(endpoint, header, [params: params])
  end

  @doc """
    Creates the URL for our endpoint
    Args:
      * endpoint - part of the API we're hitting
    Returns string
  """
  def process_url(endpoint) do
    base_url() <> endpoint
  end

  def process_response_body(body) do
    Poison.decode!(body)
  rescue
    _ -> body
  end

  def access_key do
    Application.get_env(:bokun, :access_key)
  end

  def secret_key do
    Application.get_env(:bokun, :secret_key)
  end


  defp base_url do
    if Application.get_env(:bokun, :api_url) do
      Application.get_env(:bokun, :api_url)
    else
      "http://api.bokundemo.com"
    end
  end

  defp parse_headers(method, endpoint, params) do
    current_time = Timex.format!(Timex.now, "%F %T", :strftime)
    [
      "Content-Type": "application/json",
      "Accept": "application/json",
      "X-Bokun-AccessKey": access_key,
      "X-Bokun-Date": current_time,
      "X-Bokun-Signature": get_signature(method, endpoint, params, current_time)
    ]
  end

  defp get_signature(method, endpoint, params, current_time) do
    concatened_string = get_unscrypted_signature(method, endpoint, params, current_time)
    :crypto.hmac(:sha, secret_key, concatened_string)
    |> Base.encode64
  end

  defp get_unscrypted_signature(method, endpoint, params, current_time) do
    current_time <> access_key <> method <> parse_path(endpoint, params)
  end

  def parse_path(url, params) do
    url <> "?" <> URI.encode_query(params)
  end
end
