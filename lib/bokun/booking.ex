defmodule Bokun.Booking do
  @moduledoc """
    An module for All Booking
  """

  @doc """
    Cancel booking
  ## Example
      Bokun.Booking.cancel_booking("ICT-8582", %{
        "note": "We want to cancel.",
        "refund": true,
        "notify": true
      })
  """
  def cancel_booking(booking_confirmation_code, body, params \\ %{}) do
    Bokun.post_request("/booking.json/cancel-booking/#{booking_confirmation_code}", body, set_default_currency_and_lang(params))
  end

  @doc """
    Cancel Product Booking
  ## Example
      Bokun.Booking.cancel_booking("ICT-T5312", %{
        "note": "We want to cancel.",
        "refund": true,
        "notify": true
      })
  """
  def cancel_product_booking(production_confirmation_code, body, params \\ %{}) do
    Bokun.post_request("/booking.json/cancel-product-booking/#{production_confirmation_code}", body, set_default_currency_and_lang(params))
  end

  defp set_default_currency_and_lang(params) do
    Map.merge %{currency: "EUR", lang: "FR"}, params
  end
end
