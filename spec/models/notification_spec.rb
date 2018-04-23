require 'rails_helper'

RSpec.describe Notification, type: :model do
  it 'applies a default scope to collections by updated_at descending' do
    expect(Notification.all.to_sql).to eq Notification.all.order('updated_at desc').to_sql
  end
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
end
