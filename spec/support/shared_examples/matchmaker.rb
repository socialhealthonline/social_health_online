RSpec.shared_examples 'searchable user' do
  let!(:user_2) { create(:user, state: 'AL', city: 'Hometown', zip: '35210') }

  after(:each) do
    click_button 'Search'
    expect(page).to have_content user_2.name
  end

  it 'Filter community by state' do
    select('Alabama', from: 'state')
  end

  it 'Filter community by city' do
    fill_in 'city', with: 'Hometown'
  end

  it 'Filter community zip' do
    fill_in 'zip', with: '35210'
  end
end

RSpec.shared_examples 'not searchable user' do
  let!(:user_3) { create(:user, name: 'User3', state: 'AL') }

  after(:each) do
    click_button 'Search'
    expect(page).to_not have_content user_3.name
  end

  it 'Filter community by state' do
    select('California', from: 'state')
  end

  it 'Filter community by city' do
    fill_in 'city', with: 'Random'
  end

  it 'Filter community zip' do
    fill_in 'zip', with: '12314'
  end
end
