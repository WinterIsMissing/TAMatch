require 'set'

class Applicant < ApplicationRecord
  validates_presence_of :email
  
  after_initialize do |applicant|

  end
  
end
