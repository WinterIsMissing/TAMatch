require "spec_helper"
require "matchmaker"

# spec/matchmaker.rb
describe Matchmaker do
    
    describe ".match" do
        
        context "given empty arg" do
            it "returns nil" do
                expect Matchmaker.match([],[]).nil?
                expect Matchmaker.match([], [1,2,3]).nil?
                expect Matchmaker.match([1,2,3], []).nil?
            end
        end
        
        context "given good args" do
            test_args = Matchmaker.match(
                {
                    "abby":["brett", "george", "jason"],
                    "amanda":["george", "george", "jason"],
                    "monique":["jerry", "george", "brett"],
                    "chelsea":["george"]
                },
                {
                    "brett":["amanda", "chelsea", "abby"],
                    "george":["monique", "chelsea"],
                    "jason":["amanda", "abby", "chelsea", "monique"],
                    "jerry":["abby"]
                },)
                
            it "returns a unique mapping" do
                expect test_args.keys.uniq == test_args.keys
                expect test_args.values.uniq == test_args.values
                expect test_args.keys.length == 4
                expect test_args.values.length == 4
            end
            
            it "returns a stable mapping" do
                
            end
        end
        
    end
    
end