require 'spec_helper'

describe Meetup do
  describe "Meetups should have many users" do
    it { should have_many :users }
  end

  describe "Meetups should have many members" do
    it { should have_many :members }
  end

  describe "Meetup should accept valid names, locations, and descriptions" do
    it { should have_valid(:name).when("Test Meetup") }
    it { should have_valid(:location).when("Boston") }
    it { should have_valid(:description).when("This is my test") }
  end

  describe "Meetup should not be valid if name, description, or location are nil" do
    it { should_not have_valid(:name).when(nil, "") }
    it { should_not have_valid(:location).when(nil, "") }
    it { should_not have_valid(:description).when(nil, "") }
  end
end
