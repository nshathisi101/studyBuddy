require "application_system_test_case"

class BmesseagesTest < ApplicationSystemTestCase
  setup do
    @bmesseage = bmesseages(:one)
  end

  test "visiting the index" do
    visit bmesseages_url
    assert_selector "h1", text: "Bmesseages"
  end

  test "should create bmesseage" do
    visit bmesseages_url
    click_on "New bmesseage"

    fill_in "Body", with: @bmesseage.body
    click_on "Create Bmesseage"

    assert_text "Bmesseage was successfully created"
    click_on "Back"
  end

  test "should update Bmesseage" do
    visit bmesseage_url(@bmesseage)
    click_on "Edit this bmesseage", match: :first

    fill_in "Body", with: @bmesseage.body
    click_on "Update Bmesseage"

    assert_text "Bmesseage was successfully updated"
    click_on "Back"
  end

  test "should destroy Bmesseage" do
    visit bmesseage_url(@bmesseage)
    click_on "Destroy this bmesseage", match: :first

    assert_text "Bmesseage was successfully destroyed"
  end
end
