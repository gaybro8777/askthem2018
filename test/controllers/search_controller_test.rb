require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "returns results from database" do
    get search_url, params: {q: 'Washington'}
    result = JSON.parse(response.body)
    assert_equal result['results'].size, 1
    assert_equal result['results'].first['text'],
      "U.S. Representative - Washington's 4th congressional district"
  end
end
