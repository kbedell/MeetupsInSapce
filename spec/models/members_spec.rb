require 'spec_helper'

describe Member do
  describe "confirm that a member belongs to a user, and to a meetup" do
    it { should belong_to :user }
    it { should belong_to :meetup }
  end
end
