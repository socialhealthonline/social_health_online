namespace :db do
  desc 'Load development data'
  task dev_seed: :environment do
    Customer.find_or_create_by({
      name: 'ACME',
      address: '123 Main St.',
      city: 'Hometown',
      state: 'AL',
      zip: '55555',
      contact_name: 'Tom Jones',
      contact_email: 'tom@example.com',
      contact_phone: '555-555-5555',
      service_capacity: 50
    })

    User.create({
      name: 'Lee Smith',
      email: 'jeremyleesmith@gmail.com',
      password: 'shoadmin1',
      password_confirmation: 'shoadmin1',
      admin: true,
      username: 'leesmith',
      address: '123 Main St.',
      city: 'Hometown',
      state: 'AL',
      zip: '55555',
      phone: '555-555-5555',
      gender: 'Male',
      ethnicity: 'White',
      birthdate: '1970-1-1'
    }) unless User.exists?(email: 'jeremyleesmith@gmail.com')

    User.create({
      name: 'Alex Ulbricht',
      email: 'alex.a.ulbricht@gmail.com',
      password: 'shoadmin2',
      password_confirmation: 'shoadmin2',
      admin: true,
      username: 'alex',
      address: '123 Main St.',
      city: 'Hometown',
      state: 'AL',
      zip: '55555',
      phone: '555-555-5555',
      gender: 'Male',
      ethnicity: 'White',
      birthdate: '1970-1-1'
    }) unless User.exists?(email: 'alex.a.ulbricht@gmail.com')

    User.create({
      name: 'James Quillen',
      email: 'james.quillen@gmail.com',
      password: 'shoadmin3',
      password_confirmation: 'shoadmin3',
      admin: true,
      username: 'james',
      address: '123 Main St.',
      city: 'Hometown',
      state: 'AL',
      zip: '55555',
      phone: '555-555-5555',
      gender: 'Male',
      ethnicity: 'White',
      birthdate: '1970-1-1'
    }) unless User.exists?(email: 'james.quillen@gmail.com')
  end
end
