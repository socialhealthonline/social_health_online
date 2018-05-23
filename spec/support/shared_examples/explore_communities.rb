RSpec.shared_examples 'searchable community' do
  let!(:member) { create(:member) }

  after(:each) do
    click_button 'Search'
    expect(page).to have_content member.name
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

RSpec.shared_examples 'not searchable community' do
  let!(:member) { create(:member) }

  after(:each) do
    click_button 'Search'
    expect(page).to_not have_content member.name
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
