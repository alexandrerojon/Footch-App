require 'test_helper'

class PartyRecipeControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get party_recipe_create_url
    assert_response :success
  end

  test "should get update" do
    get party_recipe_update_url
    assert_response :success
  end

end
