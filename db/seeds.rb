# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# case Rails.env
# when 'test'
    User.create(
        {
            username: 'Adam McAdmin', email: 'test_a@x.x', auth_level: 'admin',
            login_token: 'test_a', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            username: 'Ignacio Instruc', email: 'test_i@x.x', auth_level: 'instructor',
            login_token: 'test_i', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            username: 'Sander Sudent', email: 'test_s@x.x', auth_level: 'student',
            login_token: 'test_s', token_generated_at: Time.now.utc.to_s
        })
# end
