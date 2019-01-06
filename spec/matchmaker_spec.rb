require "spec_helper"
require "matchmaker"

# spec/matchmaker.rb
describe Matchmaker do
    
    describe ".match" do
        
        context "given empty arg" do
            it "returns nil" do
                expect Matchmaker.new([],[]).match_couples.nil?
                expect Matchmaker.new([], [1,2,3]).match_couples.nil?
                expect Matchmaker.new([1,2,3], []).match_couples.nil?
            end
        end
        
        context "given good args" do
                      
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
            matches = matcher.match_couples
            
            it "returns a unique mapping" do
              expect matches.keys.uniq.length == matches.values.uniq.length
            end
            
            it "returns a stable mapping" do
              expect matcher.stability > 0.9
            end
        end
        
    end
    
end