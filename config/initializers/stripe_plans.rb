STRIPE_PLANS = if Rails.env.production?
                 {
                   Monthly: 'plan_D6JtC9HwOZsR69',
                   Annual: 'plan_D8hmuJAa05mPhk'
                 }
               else
                 {
                   Monthly: 'plan_D7C6wrHdqSWmG2',
                   Annual: 'plan_D8Cd1PBcQBAvRm'
                 }
               end
