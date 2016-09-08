defmodule Bokun.Booking.Activity do

  @moduledoc """
    An module for Booking Acitivity
  """

  @doc """
  Book an Activity without Shopping Card
  ## Example
  Bokun.Booking.Activity.reserve_and_confirm(
  %{
    "activityRequest": %{
      "activityId": 283,
      "startTimeId": 639,
      "date": "2016-11-01",
      "flexibleDayOption": nil,
      "pickup": false,
      "pickupPlaceId": nil,
      "pickupPlaceDescription": nil,
      "pickupPlaceRoomNumber": nil,
      "dropoff": false,
      "dropoffPlaceId": nil,
      "dropoffPlaceDescription": nil,
      "pricingCategoryBookings": [
        %{
          "pricingCategoryId": 134,
          "extras": []
        }
      ],
      "extras": []
    },
    "externalBookingReference": "bokun-test-123",
    "note": "THIS A TEST",
    "sendCustomerNotification": false,
    "discountPercentage": nil,
    "paymentOption": "NOT_PAID",
    "manualPayment": nil,
    "chargeRequest": nil,
    "vesselId": nil,
    "harbourId": nil,
    "customer": %{
      "id": nil,
      "created": nil,
      "email": nil,
      "firstName": "Bruce",
      "lastName": "Wayne",
      "language": nil,
      "nationality": nil,
      "sex": nil,
      "dateOfBirth": nil,
      "phoneNumber": nil,
      "phoneNumberCountryCode": nil,
      "address": nil,
      "postCode": nil,
      "state": nil,
      "place": nil,
      "country": nil,
      "organization": nil,
      "passportId": nil,
      "passportExpMonth": nil,
      "passportExpYear": nil
    }
  })
  """
  def reserve_and_confirm(body, params \\ %{}) do
      Bokun.post_request("/booking.json/activity-booking/reserve-and-confirm", body, set_default_currency_and_lang(params))
  end

  defp set_default_currency_and_lang(params) do
    Map.merge %{currency: "EUR", lang: "FR"}, params
  end

end
