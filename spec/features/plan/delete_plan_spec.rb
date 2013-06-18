require "spec_helper"

feature " a user deleting a plan" do 

  let (:valid_user) do
    FactoryGirl.create(:user)
  end

  let!(:valid_location) {FactoryGirl.create(:location)}

  let(:plan_name){"hello"}

  scenario "a user makes and deletes a plan" do
    login_and_create_plan
    add_plan_entry
    plan_entry_count = PlanEntry.count
    click_link plan_name
    click_button "Delete"
    expect(page).to have_content("#{plan_name} is removed")
    expect(PlanEntry.count).to eql(plan_entry_count-1)

  end
    def login_and_create_plan
    sign_in_as(valid_user)
    fill_in "Name", with: plan_name
    click_button "Create Plan"
  end

  def add_plan_entry
    click_link "Return User Page"
    click_link "View Locations"
    click_link  valid_location.name
    select("#{plan_name}", :from => "plan[id]")
    click_button "Add to Plan"
  end
end