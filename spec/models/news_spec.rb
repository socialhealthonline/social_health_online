require 'rails_helper'

RSpec.describe News, type: :model do

  it 'default scope orders by descending created_at' do
    expect(News.all.to_sql).to eq News.all.order(created_at: :desc).to_sql
  end

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

end
