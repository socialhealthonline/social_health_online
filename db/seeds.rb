# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

15.times { |i| News.create(title: 'Title #{i}', body: 'Some text') }
15.times { |i| Notification.create(title: 'Notification #{i}', body: 'Some text') }

# Create member
unless Member.exists?(name: 'Super Admin')
  Member.create!(name: 'Super Admin',
               address: '123 Main St.',
               city: 'Hometown',
               state: 'AL',
               zip: '35210',
               contact_name: 'Super Admin',
               contact_email: 'admin@socialhealthonline.com',
               contact_phone: '555-555-5555',
               service_capacity: 1)
end

#assign super admin permission to manage all the models and controllers
member = Member.find_by_name('Super Admin')

unless User.exists?(email: 'admin@socialhealthonline.com')
  user = User.create!(email: 'admin@socialhealthonline.com',
                      password: 'Password007',
                      name: 'Social Health Online Admin',
                      city: 'Armsterdam',
                      gender:'Male',
                      display_name: 'Social Health Online Admin',
                      phone: '555-555-5555',
                      address: '123 Main St.',
                      state: 'AL',
                      zip: '55555',
                      birthdate: (Date.today - 30.years),
                      ethnicity: 'White',
                      admin: true,
                      member: member)
  user.save!
end
