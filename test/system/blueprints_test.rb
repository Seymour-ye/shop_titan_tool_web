require "application_system_test_case"

class BlueprintsTest < ApplicationSystemTestCase
  setup do
    @blueprint = blueprints(:one)
  end

  test "visiting the index" do
    visit blueprints_url
    assert_selector "h1", text: "Blueprints"
  end

  test "should create blueprint" do
    visit blueprints_url
    click_on "New blueprint"

    click_on "Create Blueprint"

    assert_text "Blueprint was successfully created"
    click_on "Back"
  end

  test "should update Blueprint" do
    visit blueprint_url(@blueprint)
    click_on "Edit this blueprint", match: :first

    click_on "Update Blueprint"

    assert_text "Blueprint was successfully updated"
    click_on "Back"
  end

  test "should destroy Blueprint" do
    visit blueprint_url(@blueprint)
    click_on "Destroy this blueprint", match: :first

    assert_text "Blueprint was successfully destroyed"
  end
end
