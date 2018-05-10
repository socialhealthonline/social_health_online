require 'rails_helper'

RSpec.describe SocialFitnessLog, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :individuals }
    it { should validate_presence_of :groups }
    it { should validate_presence_of :family }
    it { should validate_presence_of :friends }
    it { should validate_presence_of :colleagues }
    it { should validate_presence_of :significant_other }
    it { should validate_presence_of :local_community }
    it { should validate_presence_of :overall }
    it { should validate_inclusion_of(:individuals).in_array(RATINGS.values) }
    it { should validate_inclusion_of(:groups).in_array(RATINGS.values) }
    it { should validate_inclusion_of(:family).in_array(RATINGS_WITH_NA.values) }
    it { should validate_inclusion_of(:friends).in_array(RATINGS_WITH_NA.values) }
    it { should validate_inclusion_of(:colleagues).in_array(RATINGS_WITH_NA.values) }
    it { should validate_inclusion_of(:significant_other).in_array(RATINGS_WITH_NA.values) }
    it { should validate_inclusion_of(:local_community).in_array(RATINGS_WITH_NA.values) }
    it { should validate_inclusion_of(:overall).in_array(RATINGS.values) }
  end

  describe 'Association' do
    it { should belong_to(:user) }
  end
end
