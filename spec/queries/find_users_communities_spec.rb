require 'rails_helper'

RSpec.describe FindUsersCommunities do
  describe '#call' do
    let(:member_1) { create(:member) }
    let(:user) { create(:user, member: member_1) }
    
    before do
      @params = {}
      @params[:state] = 'AL'
      @params[:city] = 'Hometown'
      @params[:zip] = '35210'
      @communities = Member.where("name !=? ", user.member.name)
      @users = User.all_except(user)
      @communities = FindUsersCommunities.new(@communities, show_init_scope: true).call(@params)
      @users = FindUsersCommunities.new(@users, show_init_scope:false ).call(@params)
    end

    context 'success filter' do
      let!(:member_2) { create(:member) }
      let!(:user_2) { create(:user, state: 'AL', city: 'Hometown', zip: '35210', member: member_1) }

      before(:each) do
        expect(@communities.size).to eq(1)
        expect(@users.size).to eq(1)
      end

      context 'given state filter' do
        it 'filters by state' do; end
      end

      context 'given city filter' do
        it 'filters by city' do; end
      end

      context 'given zip filter' do
        it 'filters by zip' do; end
      end
    end

    context 'unsuccess filter' do
      before(:each) do
        expect(@communities.size).to eq(0)
        expect(@users.size).to eq(0)
      end

      context 'empty state filter' do
        it 'filters by state' do; end
      end

      context 'empty city filter' do
        it 'filters by city' do; end
      end

      context 'empty zip filter' do
        it 'filters by zip' do; end
      end
    end
  end
end
