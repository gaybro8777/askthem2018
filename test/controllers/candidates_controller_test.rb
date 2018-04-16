require 'test_helper'

class CandidatesControllerTest < ActionDispatch::IntegrationTest
  test "shows candidate" do
    candidate = candidates(:one)
    get candidate_path(candidate)
    assert response.body.include?(candidate.primary_name)
  end
end
