require 'set'

class Applicant < ApplicationRecord
  #validates_presence_of :email
  
  # DO WE NEED THE EMAIL?
  
  #after_initialize do |applicant|

   # applicant.antipref.gsub!(/[^0-9, ]/,"")
  #  applicant.preferences.gsub!(/[^0-9, ]/,"")
   # applicant.indifferent.gsub!(/[^0-9, ]/,"")
    
  #  antis = applicant.antipref.split(/, /)
  #  prefs = applicant.preferences.split(/, /)
  #  indif = applicant.indifferent.split(/, /)
    
  #  antis = antis - prefs
  #  indif = indif - prefs - antis
  #  applicant.preference_list =  prefs.append(indif).to_s.gsub(/[^0-9, ]/,"")
    
    #applicant.preference_list = applicant.preferences
  #end
  has_one :match
end