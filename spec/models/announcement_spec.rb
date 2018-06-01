require 'rails_helper'

RSpec.describe Announcement, type: :model do
  it { should belong_to(:member) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
end
