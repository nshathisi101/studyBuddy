require "test_helper"

class BmesseagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bmesseage = bmesseages(:one)
  end

  test "should get index" do
    get bmesseages_url
    assert_response :success
  end

  test "should get new" do
    get new_bmesseage_url
    assert_response :success
  end

  test "should create bmesseage" do
    assert_difference("Bmesseage.count") do
      post bmesseages_url, params: { bmesseage: { body: @bmesseage.body } }
    end

    assert_redirected_to bmesseage_url(Bmesseage.last)
  end

  test "should show bmesseage" do
    get bmesseage_url(@bmesseage)
    assert_response :success
  end

  test "should get edit" do
    get edit_bmesseage_url(@bmesseage)
    assert_response :success
  end

  test "should update bmesseage" do
    patch bmesseage_url(@bmesseage), params: { bmesseage: { body: @bmesseage.body } }
    assert_redirected_to bmesseage_url(@bmesseage)
  end

  test "should destroy bmesseage" do
    assert_difference("Bmesseage.count", -1) do
      delete bmesseage_url(@bmesseage)
    end

    assert_redirected_to bmesseages_url
  end
end
