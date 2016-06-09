require 'spec_helper'

describe Meetup do
    it { should have_many :users }

    it { should have_valid(:name).when("Test Meetup") }
    it { should_not have_valid(:name).when(nil, "") }

    it { should have_valid(:location).when("Boston") }
    it { should_not have_valid(:location).when(nil, "") }

    it { should have_valid(:description).when("This is my test") }
    it { should_not have_valid(:description).when(nil, "") }
end
