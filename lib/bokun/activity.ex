defmodule Bokun.Activity do


  def find_by_id(id) do
    Bokun.get_request("/activity.json/#{id}", [currency: "EUR", lang: "FR"])
  end

end
