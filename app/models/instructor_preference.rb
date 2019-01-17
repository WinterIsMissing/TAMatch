class InstructorPreference < ApplicationRecord
  belongs_to :user
  serialize :preferences
end
