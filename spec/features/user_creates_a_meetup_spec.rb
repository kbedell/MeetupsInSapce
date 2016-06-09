require 'spec_helper'

feature "user views all meetups" do
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

  scenario "users sees a form" do
    user
    user2
    meetup
    member
    member2
    visit '/'
    sign_in_as user
    click_link("Create new meetup")

    expect(page).to have_content("Name")
    expect(page).to have_content("Location")
    expect(page).to have_content("Description")
  end

  scenario "users recieves an error that they need to sign in" do
    user
    user2
    meetup
    member
    member2
    visit '/'
    click_link("Create new meetup")

    expect(page).to have_content("You need to be signed in to create a new meetup")
  end

  scenario "users submits a form" do
    user
    user2
    meetup
    member
    member2
    visit '/'
    sign_in_as user
    click_link("Create new meetup")
    fill_in('Name', with: 'Test Site')
    fill_in('description', with: 'This is a thing')
    fill_in('location', with: 'Boston')

    click_button("Create new meetup")

    expect(page).to have_content("You have successfully created a new meetup")
    expect(page).to have_content("Test Site")
    expect(page).to have_content("Location: Boston")
    expect(page).to have_content("Description: This is a thing")
  end
end
