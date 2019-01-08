require "spec_helper"
require "matchmaker"

# spec/matchmaker.rb
Rspec.describe Matchmaker do
    
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
        
        context "given asymmetric groups" do
          matcher = Matchmaker.new(
                          {
            'abe'  => %w[abi eve cath jan dee fay bea hope gay],
            'bob'  => %w[cath hope abi dee eve fay bea jan gay],
            'col'  => %w[hope eve abi dee bea fay gay cath jan],
            'dan'  => %w[fay dee gay hope eve jan bea cath abi],
            'ed'   => %w[jan dee bea cath fay eve abi hope gay],
            'fred' => %w[bea abi dee gay eve cath jan hope fay],
            'gav'  => %w[gay eve bea cath abi dee hope jan fay],
            'hal'  => %w[abi eve hope fay cath jan bea gay dee],
            'ian'  => %w[hope cath dee gay bea abi fay jan eve],
            'jon'  => %w[abi fay jan gay eve bea dee cath hope],
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
            'jan'  => %w[ed hal gav abe bob jon col ian fred dan],
          })
          matches = matcher.match_couples
          
          it "returns a hash anyways" do
            expect matches.respond_to?(:merge)
          end
          it "is still stable" do
            expect matcher.stability > 0.9
          end
        end
        
        context "given incomplete lists" do
          matcher = Matchmaker.new(
                          {
            'abe'  => %w[abi eve cath ivy jan],
            'bob'  => %w[cath hope abi dee eve fay bea jan ivy],
            'col'  => %w[hope eve abi dee bea fay ivy],
            'dan'  => %w[ivy fay dee gay hope eve],
            'ed'   => %w[jan dee bea cath],
            'fred' => %w[bea abi dee gay eve ivy cath jan hope fay],
            'gav'  => %w[gay eve ivy],
            'hal'  => %w[abi eve hope fay ivy cath jan bea gay dee],
            'ian'  => %w[hope cath dee gay bea abi fay],
            'jon'  => %w[abi fay jan gay eve bea dee cath ivy hope],
                          },
                          {
            'abi'  => %w[bob fred jon gav ian abe],
            'bea'  => %w[bob abe col fred gav dan ian ed],
            'cath' => %w[fred bob ed gav hal],
            'dee'  => %w[fred jon col abe ian hal],
            'eve'  => %w[jon hal fred dan abe gav col ed],
            'fay'  => %w[bob abe ed ian jon dan fred gav col],
            'gay'  => %w[jon gav hal fred bob abe col ed dan ian],
            'hope' => %w[gav jon bob abe ian dan hal ed col fred],
            'ivy'  => %w[ian col hal gav fred bob],
            'jan'  => %w[ed hal gav abe bob jon col ian fred dan],
          })
            matches = matcher.match_couples
            
            it "returns a mapping" do
              expect matches.respond_to?(:merge)
            end
            it "returns a complete mapping" do
              expect matches.keys.uniq.length == matches.values.uniq.length
            end
            it "is still stable" do
              expect matcher.stability > 0.9
            end
            
            it "does not nil-out" do 
              expect !(matches.values).include?(nil)
              expect !(matches.values).include?("")
            end
          end
        
    end
    
end