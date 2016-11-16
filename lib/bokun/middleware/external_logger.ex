defmodule Bokun.Middleware.ExternalLogger do
  use Timex

  def call(env, next, _opts) do
    request_env     = env
    req_start_time  = Timex.now

    response_env = env = Tesla.run(env, next)
    duration = Timex.diff(Timex.now, req_start_time, :seconds)

    log_external(request_env, response_env, duration)

    env
  end

  def external_engine do
    Application.get_env(:bokun, :external_engine)
  end

  def log_external(request_env, response_env, request_time) do
    if external_engine do
      apply(external_engine, :log, [request_env, response_env, %{request_time: request_time}])
    end
  end
end
