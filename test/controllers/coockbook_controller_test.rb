require 'test_helper'

class CoockbookControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get coockbook_index_url
    assert_response :success
  end

  test "should get create" do
    get coockbook_create_url
    assert_response :success
  end

  test "should get destroy" do
    get coockbook_destroy_url
    assert_response :success
  end

end
