STRIPE_PLANS = if Rails.env.production?
                 {
                   Monthly: 'plan_DVVfJm6bmyYQtm',
                   Annual: 'plan_DVVfUzzanSpWwy'
                 }
               else
                 {
                   Monthly: 'plan_DVVYdBvc0KnhhV',
                   Annual: 'plan_DVW4C1tgbb49Fy'
                 }
               end
