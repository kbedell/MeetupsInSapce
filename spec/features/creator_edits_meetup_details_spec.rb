require 'spec_helper'

feature "Creator edits a meetup's details" do
  let(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  let(:user2) do
    User.create(
      provider: "github",
      uid: "2",
      username: "herpderp",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  let(:meetup) do
    Meetup.create(
      name: "test meetup",
      description: "This is our meetup",
      location: "Boston"
      )
  end

  let(:member) do
    Member.create(
      user_id: user.id,
      meetup_id: meetup.id,
      creator: true
    )
  end

  let(:member2) do
    Member.create(
    user_id: user2.id,
    meetup_id: meetup.id
    )
  end

  let(:set_up) do
    user
    user2
    meetup
    member
    member2
  end

  scenario "users sees a form" do
    set_up
    visit '/'
    sign_in_as user
    click_link("test meetup")
    click_link("Edit Meetup")

    expect(page).to have_field("Name", with: "test meetup")
    expect(page).to have_field("Location", with: "Boston")
    expect(page).to have_field("Description", with: "This is our meetup")
  end

  scenario "users recieves an error that they need to sign in" do
    set_up
    visit '/'
    visit '/meetups/5/edit'
    click_button('Edit Meetup')

    expect(page).to have_content("You need to be logged in to edit a meetup")
  end

  scenario "users submits the edit form" do
    set_up
    visit '/'
    sign_in_as user
    click_link("test meetup")
    click_link("Edit Meetup")

    fill_in('Name', with: 'Test Site')
    fill_in('description', with: 'Updated description')
    fill_in('location', with: 'Boston')

    click_button("Edit Meetup")

    expect(page).to have_content("You have successfully edited your meetup")
    expect(page).to have_content("Test Site")
    expect(page).to have_content("Location: Boston")
    expect(page).to have_content("Description: Updated description")
  end

  scenario "users attempts to submit a form with invalid fields" do
    set_up
    visit '/'
    sign_in_as user
    click_link("test meetup")
    click_link("Edit Meetup")

    fill_in('Name', with: "")
    fill_in('description', with: "")
    fill_in('location', with: "")

    click_button("Edit Meetup")

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Location can't be blank")
  end
end
