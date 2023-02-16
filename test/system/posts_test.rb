require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
  end

  test "visiting the index" do
    visit posts_url
    assert_selector "h1", text: "Posts"
  end

  test "creating a Post" do
    visit posts_url
    click_on "New Post"

    fill_in "Category", with: @post.category_id
    fill_in "Date", with: @post.date
    fill_in "Description ar", with: @post.description_ar
    fill_in "Description en", with: @post.description_en
    fill_in "Flag", with: @post.flag
    fill_in "Reference", with: @post.reference
    fill_in "Status", with: @post.status
    fill_in "Subject ar", with: @post.subject_ar
    fill_in "Subject en", with: @post.subject_en
    fill_in "Timestamp", with: @post.timestamp
    fill_in "Views", with: @post.views
    click_on "Create Post"

    assert_text "Post was successfully created"
    click_on "Back"
  end

  test "updating a Post" do
    visit posts_url
    click_on "Edit", match: :first

    fill_in "Category", with: @post.category_id
    fill_in "Date", with: @post.date
    fill_in "Description ar", with: @post.description_ar
    fill_in "Description en", with: @post.description_en
    fill_in "Flag", with: @post.flag
    fill_in "Reference", with: @post.reference
    fill_in "Status", with: @post.status
    fill_in "Subject ar", with: @post.subject_ar
    fill_in "Subject en", with: @post.subject_en
    fill_in "Timestamp", with: @post.timestamp
    fill_in "Views", with: @post.views
    click_on "Update Post"

    assert_text "Post was successfully updated"
    click_on "Back"
  end

  test "destroying a Post" do
    visit posts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Post was successfully destroyed"
  end
end
