#lib/matchmaker.rb
=begin
Matchmaker, class; Person, helper class

Usage: given item_group_1 and item_group_2, returns a unique stable matching 
of item1 <-> item2 where item1 is from group 1 and item 2 is from group 2

for matching only:
Matchmaker.new(item_group_1, item_group_2).match_couples

to measure stability:
matchmaker = Matchmaker.new
matchmaker.match_couples
matchmaker.stability

Tests contained in: ./spec/matchmaker_spec.rb
9/9 pass

untested: 
- $DEBUG configurable from command line or from Matchmaker.new
  reason:unsure how. unsure if necessary
=end

require 'set'

$DEBUG = false | ARGV[0]

class Person
  def initialize(name)
    @name = name
    @fiance = nil
    @preferences = []
    @proposals = []
  end
  attr_reader :name, :proposals
  attr_accessor :fiance, :preferences
 
  def free
    @fiance = nil
  end
 
  def single?
    @fiance == nil
  end
 
  def engage(person)
    self.fiance = person
    person.fiance = self
  end
  
  def final_choice?(person)
    @preferences.last == person
  end
 
  def better_choice?(person)
    return true if @fiance.nil?
    fi_idx = @preferences.index(@fiance)
    new_idx = @preferences.index(person)
    return true if fi_idx.nil?
    return false if new_idx.nil?
    return false if @fiance.final_choice?(self)
    new_idx < fi_idx
  end
 
  def propose_to(person)
    puts "#{self} proposes to #{person}" if $DEBUG
    @proposals << person
    person.respond_to_proposal_from(self)
  end
 
  def respond_to_proposal_from(person)
    if single?
      puts "#{self} accepts proposal from #{person}" if $DEBUG
      engage(person)
    elsif better_choice?(person)
      puts "#{self} dumps #{@fiance} for #{person}" if $DEBUG
      @fiance.free
      engage(person)
    else
      puts "#{self} rejects proposal from #{person}" if $DEBUG
    end
  end
  
  def more_preferable_people
    ( @preferences.partition {|p| better_choice?(p)} ).first
  end
end

class Matchmaker
  def valid_arg(thing)
    return !thing.nil? && thing.respond_to?(:merge)
  end
  
  def self.personify(men_prefs, women_prefs)
    prefs = men_prefs.merge(women_prefs)
    men = Hash[
        men_prefs.keys.collect { |name| [name, Person.new(name)]}
        ]
    women = Hash[
        women_prefs.keys.collect { |name| [name, Person.new(name)]}
        ]
    men.each {|name, man| man.preferences = women.values_at(*prefs[name])}
    women.each {|name, woman| woman.preferences = men.values_at(*prefs[name])}
    reversed = false
    if men.keys.length > women.keys.length
      men, women = women, men 
      reversed = true
    end
    
    ret_hash = Hash.new
    ret_hash[:men] = men
    ret_hash[:women] = women
    ret_hash[:reversed] = reversed
    return ret_hash
  end
    
  
  def initialize(men_prefs, women_prefs, debug = false)
    $DEBUG = debug
    unless valid_arg(men_prefs) && valid_arg(women_prefs)
      @men = nil
      @women = nil
      return
    end
    persons = Matchmaker.personify(men_prefs, women_prefs)
    @men = persons[:men]
    @women = persons[:women]
  end
  
  def match_couples
    return nil if @men.nil? || @women.nil?
    @men.each_value {|man| man.free}
    @women.each_value {|woman| woman.free}
    while m = @men.values.find {|man| man.single?} do
      puts "considering single man #{m}" if $DEBUG
      w = m.preferences.find {|woman| not m.proposals.include?(woman)}
      m.propose_to(w)
    end
    @men.each_value.collect {|man| puts "#{man} + #{man.fiance}"} if $DEBUG
    ret_hash = Hash.new
    @men.each{|k,v| ret_hash[k] = v.fiance.name}
    return ret_hash
  end
  
  def self.course_match_initialize(courses, applicants, opts)
    course_prefs = []
    applicants.each { |x| course_prefs.push(x.email) }
    course_hash = Hash.new([])
    app_hash = Hash.new([])
    
    courses.each do |x|
      my_prefs = course_prefs #.shuffle
      my_string = ""
      openings = 0
      openings += opts[:ta] ? x.ta_count : 0
      openings += opts[:grader] ? x.grader_count : 0
      
      next if openings < 1
      (1..openings).each do |i|
        inner_string = "#{x.name}-#{i}"
        my_string << inner_string << ", "
        course_hash[inner_string] = my_prefs
      end
      
      my_string.chomp(", ")
      
      applicants.each {|y| y.preference_list.to_s.gsub!(x.name, my_string) }
    end
    
    applicants.each do |x|
      arry = x.preference_list.split(/, /)
      arry.delete_if {|y| y.length < 3}
      app_hash[x.email] = arry
    end
    
    return_hash = Hash.new
    return_hash[:course_hash] = course_hash
    return_hash[:app_hash] = app_hash
    return return_hash
  end
  
  def self.course_match(courses, applicants, opts={:ta=>true, :grader=>false})
    # matches, score = Matchmaker.course_match(Course.all, Applicant.all)
    args = Matchmaker.course_match_initialize(courses, applicants, opts)
    
    matchmaker = Matchmaker.new(args[:course_hash], args[:app_hash])
    matches = matchmaker.match_couples
    return matches
  end
  
  def self.stability(men)
    unstable = Set.new
    unmatched = 0
    men.each_value do |man|
      woman = man.fiance
      if woman.null?
        unmatched += 1
        next
      end
   
      man.more_preferable_people.each do |other_woman|
        if other_woman.more_preferable_people.include?(man)
          unstable << [man, other_woman]
        end
      end
      woman.more_preferable_people.each do |other_man|
        if other_man.more_preferable_people.include?(woman)
          unstable << [other_man, woman]
        end
      end
    end
   
    return (1.0 - unstable.length.to_f / men.keys.length.to_f), unmatched, unstable
  end
  
  def self.course_match_score(xargs, opts={:ta=>true, :grader=>false})
    warnings = []
    course_list = xargs[:courses]
    applicants = xargs[:applicants]
    matches = xargs[:matches]
    if course_list.nil? || applicants.nil? || matches.nil?
      # xargs should be a hash with :courses, :applicants, and :matches fields
      return -1
    end
    score = 100
    opening_pts = score / course_list.length
    #prof_pts = fill_pts = applicant_pts = opening_pts / 3
    args = Matchmaker.course_match_initialize(course_list, applicants, opts)
    
    persons = Matchmaker.personify(args[:course_hash], args[:app_hash])
    courses = persons[:men]
    apps = persons[:women]
    if persons[:reversed]
      warnings.push("There are less applicants than openings!")
      courses, apps = apps, courses
    end 
    
    courses.each do |k, v|
      v.engage(apps[matches[k]])
    end
    
    stability, unmatched, unstable = Matchmaker.stability(courses)
    score -= unmatched * opening_pts
    if unmatched > 0
      warnings.push("There are unmatched courses!")
    end
    score *= stability
    if stability <= 0.99
      warnings.push("Stability is not 100%")
      unstable.each do |a,b|
        warnings.push("#{a} & #{b}: applicants should be swapped for optimal stability.")
      end
    end
    
    warnings.push("There are no warnings!") if warnings.length < 1
    return score, warnings
  end
  
  def stability
    unstable = Set.new
    @men.each_value do |man|
      woman = man.fiance
      puts "considering #{man} and #{woman}" if $DEBUG
   
      man.more_preferable_people.each do |other_woman|
        if other_woman.more_preferable_people.include?(man)
          puts "an unstable pairing: #{man} and #{other_woman}" if $DEBUG
          unstable << [man, other_woman]
        end
      end
      woman.more_preferable_people.each do |other_man|
        if other_man.more_preferable_people.include?(woman)
          puts "an unstable pairing: #{woman} and #{other_man}" if $DEBUG
          unstable << [other_man, woman]
        end
      end
    end
   
    if unstable.empty?
      return 1.0
    else
      unstable.each do |a,b|
        puts "#{a} engaged #{a.fiance}, prefers #{b} && #{b} engaged #{b.fiance}, prefers #{a}" if $DEBUG
      end
      return (1.0 - unstable.length.to_f / @men.keys.length.to_f)
    end
  end
end


