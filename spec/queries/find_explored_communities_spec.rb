require 'rails_helper'

RSpec.describe FindExploredCommunities do
  describe '#call' do
    let(:member_1) { create(:member) }
    let(:user) { create(:user, member: member_1) }

    before do
      @params = {}
      @params[:state] = 'AL'
      @params[:city] = 'Hometown'
      @params[:zip] = '35210'
    end

    context 'success filter' do
      let!(:member_2) { create(:member) }

      before do
        @communities = Member.where("name !=? ", user.member.name)
        @communities = FindExploredCommunities.new(@communities).call(@params)
      end

      context 'given state filter' do
        it 'filters by state' do
          expect(@communities.size).to eq(1)
        end
      end

      context 'given city filter' do
        it 'filters by city' do
          expect(@communities.size).to eq(1)
        end
      end


      context 'given zip filter' do
        it 'filters by zip' do
          expect(@communities.size).to eq(1)
        end
      end
    end

    context 'unsuccess filter' do
      before do
        @communities = Member.where("name !=? ", user.member.name)
        @communities = FindExploredCommunities.new(@communities).call(@params)
      end

      context 'empty state filter' do
        it 'filters by state' do
          expect(@communities.size).to eq(0)
        end
      end

      context 'empty city filter' do
        it 'filters by city' do
          expect(@communities.size).to eq(0)
        end
      end


      context 'empty zip filter' do
        it 'filters by zip' do
          expect(@communities.size).to eq(0)
        end
      end
    end
  end
end
