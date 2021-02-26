# frozen_string_literal: true

require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: 'webdev')
    @category2 = Category.create(name: 'gamedev')
  end

  test 'should show categories listing' do
    get '/categories'
    assert_select 'a[href=?]', category_path(@category), text: @category.name
    assert_select 'a[href=?]', category_path(@category2), text: @category2.name
  end
end
