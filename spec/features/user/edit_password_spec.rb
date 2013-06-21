require "spec_helper"
## User Story
## As a User, I want to edit my password

## AC
## let user edit password
feature "a user can edit their password" do
  let (:valid_user) do
    FactoryGirl.create(:user)
  end
  scenario "redirects them to the home page with a cheerful good-bye" do
    visit(root_path)
    sign_in_as(valid_user)
    click_link("Edit profile")
    fill_in "Password", with: "1qaz2wsx"
    fill_in "Password confirmation", with: "1qaz2wsx"
    fill_in "Current password", with: valid_user.password
    click_button "Update"
    expect(page).to have_content("You updated your account successfully.")
  end

  scenario "flashes an error if new passwords don't match " do
    visit(root_path)
    sign_in_as(valid_user)
    click_link("Edit profile")
    fill_in "Password", with: "1qaz2wsx"
    fill_in "Password confirmation", with: "1qaz2wsx111"
    fill_in "Current password", with: valid_user.password
    click_button "Update"
    expect(page).to have_content("1 error")
  end
end
