class SocialFitnessLog < ApplicationRecord
  validates_presence_of :individuals, :groups, :family, :friends, :colleagues, :significant_other, :local_community, :overall

  validates_inclusion_of :individuals, in: RATINGS.values
  validates_inclusion_of :groups, in: RATINGS.values
  validates_inclusion_of :family, in: RATINGS_WITH_NA.values
  validates_inclusion_of :friends, in: RATINGS_WITH_NA.values
  validates_inclusion_of :colleagues, in: RATINGS_WITH_NA.values
  validates_inclusion_of :significant_other, in: RATINGS_WITH_NA.values
  validates_inclusion_of :local_community, in: RATINGS_WITH_NA.values
  validates_inclusion_of :overall, in: RATINGS.values

  default_scope { order('created_at desc') }


  belongs_to :user
end
