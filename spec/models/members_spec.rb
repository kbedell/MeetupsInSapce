require 'spec_helper'

describe Member do
    it { should belong_to :user }
    it { should belong_to :meetup }
end
