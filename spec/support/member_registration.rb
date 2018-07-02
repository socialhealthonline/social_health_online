require 'rails_helper'

def fill_stripe_elements(card)
  within_frame("__privateStripeFrame3") do
    card.to_s.chars.each do |piece|
      find_field('cardnumber').send_keys(piece)
    end

    find_field('exp-date').send_keys("0122")
    find_field('cvc').send_keys '123'
  end
end
