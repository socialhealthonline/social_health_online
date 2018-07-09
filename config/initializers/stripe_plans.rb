STRIPE_PLANS = if Rails.env.production?
                 {
                   Annual: 'plan_D8hmuJAa05mPhk',
                   Monthly: 'plan_D6JtC9HwOZsR69'
                 }
               else
                 {
                   Annual: 'plan_D8Cd1PBcQBAvRm',
                   Monthly: 'plan_D7C6wrHdqSWmG2'
                 }
               end
