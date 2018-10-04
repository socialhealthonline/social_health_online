class Target < ApplicationRecord
  validates :month, :weekone, :targetone, :weektwo, :targettwo, :weekthree, :targetthree, :weekfour, :targetfour, presence: true
end
