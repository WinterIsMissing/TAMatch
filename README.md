# TAMatch
TA Application and Assignment System as a CSCE 431-Singapore 2019 Project

## What is TAMatch?
### Purpose
This project aims to serve as a platform for Texas A&M Graduate Students and faculty to
minimize human intervention in the application process for TA's.

### Functionalities
- Allow professors to preference TA’s
- Allow TA’s to specify which kinds of classes they want / don’t want to teach
- Maximize amount of successful matches between preferred professors/TA’s/classes and quantify it with a score
- Allow admin to manage instructors, matches, and applications

### Proposed Functionalities
- Notification system (maybe even via email?)
- Overhaul of matchmaker (to allow for multiple sections of a course for example)
- Allow for course/section creation
- Allow TA’s to preference professors

### Check it out!
- Demo - [Heroku](https://young-lowlands-69353.herokuapp.com/)
- Our Progress :D - [Pivotal Tracker](https://www.pivotaltracker.com/n/projects/2234694)

## Testing
Some setup must be done in order to get testing functionality up and running.

- Clone the repository into an aws instance w/ ruby and rails all set.
- Make sure that Postgresql is primed.
  ```
    sudo yum install postgresql postgresql-server postgresql-devel postgresql-contrib postgresql-docs
  ```
  ```
    sudo service postgresql initdb
  ```
  ```
    sudo service postgresql start
  ```
- `cd` into the project directory and do the usual ruby setup.
  ```
    bundle install
  ```
- Create a super user account for ec2-user (_ignore the directory errors_)
  ```
    sudo -u postgres createuser -s ec2-user
  ```
  ```
    sudo -u postgres createdb ec2-user
  ```
  ```
    sudo su postgres
    psql
    ALTER USER "ec2-user" WITH SUPERUSER;
    \q
    exit
  ```
- Set up the test database *(cd into the project directory)*
  ```
    rails db:reset RAILS_ENV=test
  ```
- You're good to go!

## Deploying
This section assumes you have went through the previous section. 

- In order to run on the AWS instance, run:
  ```
  rails server
  ```
  You should be able to use the preview feature of the Cloud9 environment to see the application's log in view.

- In order to run on the Heroku:
  - Make sure you have the postgres add-on on your application in the Heroku Dashboard.
  - Set up Google OAuth:
    - Create an application using Google's developer console. Here's a [tutorial](https://developers.google.com/identity/protocols/OAuth2UserAgent).
      - Grab the Client ID and secret
      - Set your heroku app as an authorized javascript origin (https://YOUR_APP.herokuapp.com)
      - Set your OAuth callback as an authorized redirect URI (https://YOUR_APP.herokuapp.com/auth/google/callback)
    - With your Client ID and secret, create a source file, but MAKE SURE this is not passed around willy-nilly. ([Example](https://stackoverflow.com/questions/19331497/set-environment-variables-from-file-of-key-pair-values))
    - For example:

      `creds.txt`
      ```
        export OAUTH_ID="YOUR_CLIENT_ID"
        export OAUTH_KEY="YOUR_CLIENT_SECRET"
      ```
      ```
      > source creds.txt
      ```
  - Assuming you've [linked your local repo to your heroku app](https://devcenter.heroku.com/articles/git#prerequisites-install-git-and-the-heroku-cli), `git push heroku master` should bring your app to Heroku.
  - In order to manage your database, make a note of these commands:
    - `heroku restart`
    - `heroku pg:reset DATABASE`
    - `heroku run rails db:migrate`
    - `heroku run rails db:seed`
   
## Data
This section covers how you work with the different kinds of data (Courses, Users, Applications)
- The seed data for courses and applicants are located in `TAMatch/app/assets/` with their format being specified by the header in each file.
- The actual seed file is located in `TAMatch/db/seeds.rb`
- In case you want to change something on the fly on heroku, run `heroku run rails console`. Here, you are able to run commands such as `u = User.find_by(email: "test_s@x.x")` and modify them as you see fit before running `u.save`.
- In order to test the different views (Admin, Instructor, Student), there are prepared test accounts to be used. Just navigate to `WEBAPPURL/auth?test_*`, where "*" is 'a', 'i', or 's', corresponding to the aforementioned roles. These can only be used once, since it resets the authentication token, but `rails db:reset` can be ran to reset them. If you want to prepare your own test accounts or seed an account with your email, `seeds.rb` should have an ample amount of examples to look at.

*Brought to you by Team Winter is Missing (Ivan Delgado, Ryan Garmeson, Mackenzie Ford, Big-E Kee, and Benjamin Wong)*
