#lib/matchmaker.rb
require 'set'

$DEBUG = true

class Person
  def initialize(name)
    @name = name
    @fiance = nil
    @preferences = []
    @proposals = []
  end
  attr_reader :name, :proposals
  attr_accessor :fiance, :preferences
 
  def to_s
    @name
  end
 
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
 
  def better_choice?(person)
    @preferences.index(person) < @preferences.index(@fiance)
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
  def initialize(men_prefs, women_prefs)
      prefs = men_prefs.merge(women_prefs)
      @men = Hash[
          men_prefs.keys.collect { |name| [name, Person.new(name)]}
          ]
      @women = Hash[
          women_prefs.keys.collect { |name| [name, Person.new(name)]}
          ]
      @men.each {|name, man| man.preferences = @women.values_at(*prefs[name])}
      @women.each {|name, woman| woman.preferences = @men.values_at(*prefs[name])}
  end
  
  def match_couples
    puts @men.keys
    puts @women.keys
    @men.each_value {|man| man.free}
    @women.each_value {|woman| woman.free}
    while m = @men.values.find {|man| man.single?} do
      puts "considering single man #{m}" if $DEBUG
      w = m.preferences.find {|woman| not m.proposals.include?(woman)}
      m.propose_to(w)
    end
    puts "all done"
    @men.each_value.collect {|man| puts "#{man} + #{man.fiance}"} if $DEBUG
    return Hash.new(@men.each{|k,v| [k,v.fiance]})
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
        puts "#{a} is engaged to #{a.fiance} but would prefer #{b}, and #{b} is engaged to #{b.fiance} but would prefer #{a}"
      end
      return (1.0 - unstable.length.to_f / @men.keys.length.to_f)
    end
  end
end

matcher = Matchmaker.new(
                {
  'abe'  => %w[abi eve cath ivy jan dee fay bea hope gay],
  'bob'  => %w[cath hope abi dee eve fay bea jan ivy gay],
  'col'  => %w[hope eve abi dee bea fay ivy gay cath jan],
  'dan'  => %w[ivy fay dee gay hope eve jan bea cath abi],
  'ed'   => %w[jan dee bea cath fay eve abi ivy hope gay],
  'fred' => %w[bea abi dee gay eve ivy cath jan hope fay],
  'gav'  => %w[gay eve ivy bea cath abi dee hope jan fay],
  'hal'  => %w[abi eve hope fay ivy cath jan bea gay dee],
  'ian'  => %w[hope cath dee gay bea abi fay ivy jan eve],
  'jon'  => %w[abi fay jan gay eve bea dee cath ivy hope],
                },
                {
  'abi'  => %w[bob fred jon gav ian abe dan ed col hal],
  'bea'  => %w[bob abe col fred gav dan ian ed jon hal],
  'cath' => %w[fred bob ed gav hal col ian abe dan jon],
  'dee'  => %w[fred jon col abe ian hal gav dan bob ed],
  'eve'  => %w[jon hal fred dan abe gav col ed ian bob],
  'fay'  => %w[bob abe ed ian jon dan fred gav col hal],
  'gay'  => %w[jon gav hal fred bob abe col ed dan ian],
  'hope' => %w[gav jon bob abe ian dan hal ed col fred],
  'ivy'  => %w[ian col hal gav fred bob abe ed jon dan],
  'jan'  => %w[ed hal gav abe bob jon col ian fred dan],
})
matcher.match_couples
puts "#{matcher.stability.to_f * 100.0} percent stable"
              