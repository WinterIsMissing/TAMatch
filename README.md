# TAMatch
TA Application and Assignment System as a CSCE 431-Singapore 2019 Project

## What is TAMatch?
### Purpose
This project aims to serve as a platform for Texas A&M Graduate Students and faculty to
minimize human intervention in the application process for TA's.

### Proposed functionalities
- Allow professors to preference TA’s
- Allow TA’s to preference professors or classes
- Allow TA’s to specify which kinds of classes they want / don’t want to teach
- Maximize amount of successful matches between preferred professors/TA’s/classes.

### Check it out!
- Demo - [Heroku](https://young-lowlands-69353.herokuapp.com/)
- Our Progress :D - [Pivotal Tracker](https://www.pivotaltracker.com/n/projects/2234694)

## Testing
Some setup must be done in order to get testing functionality up and running.

- Clone the repository into an aws instance w/ ruby and rails all set.
- `cd` into the project directory and do the usual.
  ```
    bundle install
  ```
- Make sure that Postgresql is primed.
  ```
    sudo yum install postgresql postgresql-server postgresql-devel postgresql-contrib postgresql-docs
  ```
  ```
    sudo service postgresql start
  ```
- Create a super user account for ec2-user
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
