
require "application_system_test_case"

class LineItemsTest < ApplicationSystemTestCase

	include ActionView::Helpers::NumberHelper

	setup do
		login_as users(:accountant)

		@quote 					= quotes(:first)
		@line_item_date = line_item_dates(:today)
		@line_item 			= line_items(:room_today)

		visit quote_path(@quote)
	end

	test "Creating a new line item" do
		
		assert_selector "h1", text: "First quote"

		within "##{dom_id(@line_item_date)}" do
			click_on "Add item", match: :first
		end

		assert_selector "h1", text: "First quote"

		fill_in "name", with: "my new item"
		fill_in "Quantity", with: 1
		fill_in "Unit price", with: 1
		click_on "Create item"

		assert_selector "h1", text: "First quote"
		assert_text "my new item"
		assert_text "Item successfully created!"
	end

	test "Updating a line item" do 

		assert_selector "h1", text: "First quote"

		within "##{dom_id(@line_item)}" do
			click_on "Edit"
		end

		assert_selector "h1", text: "First quote"
		fill_in "name", with: "Meeting room updated"
		fill_in "Unit price", with: 1234

		click_on "Update"
		assert_selector "h1", text: "First quote"
		assert_text "Item successfully updated!"
		assert_text "Meeting room updated"
		assert_text number_to_currency(1234)
	end

	test "Destroying a line item" do
    assert_selector "h1", text: "First quote"

    within "##{dom_id(@line_item_date)}" do
			assert_text @line_item.name
		end

		within "##{dom_id(@line_item)}" do
			click_on "Delete"
		end

    within "##{dom_id(@line_item_date)}" do
			assert_no_text @line_item.name
		end

    assert_selector "h1", text: "First quote"
    assert_text "Item successfully deleted!"
  end

end
