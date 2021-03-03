require 'test_helper'

class PartyIngredientsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get party_ingredients_new_url
    assert_response :success
  end

  test "should get create" do
    get party_ingredients_create_url
    assert_response :success
  end

end
