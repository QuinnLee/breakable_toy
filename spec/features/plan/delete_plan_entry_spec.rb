require "spec_helper"

feature "add a plan entry to a plan" do
  let!(:valid_user) {FactoryGirl.create(:user)}
  let!(:valid_location) {FactoryGirl.create(:location)}
  let(:plan_name){"hello"}

  scenario "#plan entries can be added to in the location index" do
    login_and_create_plan
    add_plan_entry
    click_button "Delete Entry"
    expect(page).to have_content("deleted")
    expect(PlanEntry.count).to eql 0
  end

  def login_and_create_plan
    sign_in_as(valid_user)
    click_link "User Page"
    fill_in "Name", with: plan_name
    click_button "Create Plan"
  end

  def add_plan_entry
    click_link "Locations"
    click_link  valid_location.name
    select("#{plan_name}", :from => "plan[id]")
    click_button "Add to Plan"
  end

end