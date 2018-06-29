STRIPE_PLANS = if Rails.env.production?
                 {
                   Yearly: 'plan_D8hmuJAa05mPhk',
                   Mountly: 'plan_D6JtC9HwOZsR69'
                 }
               else
                 {
                   Yearly: 'plan_D8Cd1PBcQBAvRm',
                   Mountly: 'plan_D7C6wrHdqSWmG2'
                 }
               end
