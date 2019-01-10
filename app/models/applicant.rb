require 'set'

class Applicant < ApplicationRecord
  validates_presence_of :email
  
  after_initialize do |applicant|
    antis = applicant.antipref.gsub(/[^0-9, ]/,"")
    prefs = applicant.preferences.gsub(/[^0-9, ]/,"")
    indif = applicant.indifferent.gsub(/[^0-9, ]/,"")
    
    antis = antis.split(/, /)
    prefs = prefs.split(/, /)
    indif = indif.split(/, /)
    
    antis = antis - prefs
    indif = indif - prefs - antis
    applicant.preference_list =  prefs.append(indif).to_s.gsub(/[^0-9, ]/,"")
  end
  
end
