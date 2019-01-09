# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# case Rails.env
# when 'test'

    #Admin
    User.create(
        {
            fullname: 'Adam McAdmin', username: 'Adam McAdmin', email: 'test_a@x.x', auth_level: 'admin',
            login_token: 'test_a', token_generated_at: Time.now.utc.to_s
        })
        
    #Instructor
    User.create(
        {
            fullname: 'Ignacio Instruc', username: 'Ignacio Instruc', email: 'test_i@x.x', auth_level: 'instructor',
            login_token: 'test_i', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            fullname: 'Rory Rotinuc', username: 'Rory Rotinuc', email: 'test_i2@x.x', auth_level: 'instructor',
            login_token: 'test_i2', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            fullname: 'Cecilia Coroutin', username: 'Cecilia Coroutin', email: 'test_i3@x.x', auth_level: 'instructor',
            login_token: 'test_i3', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            fullname: 'Oreia Oritin', username: 'Oreia Oritin', email: 'test_i4@x.x', auth_level: 'instructor',
            login_token: 'test_i4', token_generated_at: Time.now.utc.to_s
        })
    
    #Student
    User.create(
        {
            fullname: 'Sander Sudent', username: 'Sander Sudent', email: 'test_s@x.x', auth_level: 'student',
            login_token: 'test_s', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            fullname: 'Sudan Summit', username: 'Sudan Summit', email: 'test_s1@x.x', auth_level: 'student',
            login_token: 'test_s1', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            fullname: 'Smitty Sunted', username: 'Smitty Sunted', email: 'test_s2@x.x', auth_level: 'student',
            login_token: 'test_s2', token_generated_at: Time.now.utc.to_s
        })
    User.create(
        {
            fullname: 'Danny Fenton', username: 'Danny Fenton', email: 'test_s3@x.x', auth_level: 'student',
            login_token: 'test_s3', token_generated_at: Time.now.utc.to_s
        })
# end
