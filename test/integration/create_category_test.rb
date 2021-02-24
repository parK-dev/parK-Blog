require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
    get new_category_path
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: "test"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "test", response.body
  end

  test "get new category form and reject category submission" do
    get new_category_path
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: ""} }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

end
