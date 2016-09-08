defmodule Bokun.Activity do

  @moduledoc """
  An module for Bokun Activity
  """

  @doc """
  Get information about specific activity by id
  ## Example
      Bokun.Activity.find_by_id(283)
  """
  def find_by_id(id, params \\ %{}) do
    Bokun.get_request("/activity.json/#{id}", set_default_currency_and_lang(params))
  end

  @doc """
  Get information about specific activity by slug
  ## Example
      Bokun.Activity.find_by_slug("visite-guidee-au-mont-saint-michel")
  """
  def find_by_slug(slug, params \\ %{}) do
    Bokun.get_request("/activity.json/slug/#{slug}", set_default_lang(params))
  end

  @doc """
  Get avaibility about specific activity
  ## Example
      Bokun.Activity.get_avaibilities(283, %{start: "2016-11-01", end: "2016-11-02"})
  """
  def get_avaibilities(id, params \\ %{}) do
    Bokun.get_request("/activity.json/#{id}/availabilities", set_default_currency_and_lang(params))
  end

  @doc """
  Search on All Activity
  ## Example
      Bokun.Activity.search(%{})
  """
  def search(body \\ %{}, params \\ %{}) do
    Bokun.post_request("/activity.json/search", body, set_default_currency_and_lang(params))
  end

  @doc """
  Check how much an activity booking would cost
  ## Example
      Bokun.Activity.check_price(%{
        "activityId": 283,
        "startTimeId": 639,
        "date": "2011-11-01",
        "pricingCategoryBookings": [
          %{"pricingCategoryId": "134"}
        ]
      })
  """
  def check_price(body, params \\ %{}) do
    Bokun.post_request("/activity.json/check-prices", body, set_default_currency_and_lang(params))
  end

  defp set_default_lang(params) do
    Map.merge %{lang: "FR"}, params
  end

  defp set_default_currency_and_lang(params) do
    Map.merge %{currency: "EUR", lang: "FR"}, params
  end

end
