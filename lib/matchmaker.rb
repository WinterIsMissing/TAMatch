#lib/matchmaker.rb
        

class Matchmaker
    
    class Woman
        attr_accessor :fiance
        attr_accessor :proposals
        attr_reader :key
        @proposals = []
        def initialize(idx, preferences)
            @fiance = nil
            @preferences = preferences
            @key = key
        end
        
        def change_fiance(old, new)
            
            old.message = "break" unless old.nil?
            new.message = "accept"
            @fiance = new
        end
        
        def process_turn
            return nil unless @proposals.length > 0
            prospects = @proposals
            prospects = @proposals.prepend(@fiance) unless @fiance.nil?
            q = prospects.sort do |a,b|
                @preferences.find_idx(a) <=> @preferences.find_idx(b)
            end.first
            change_fiance(@fiance, q) unless @fiance == q
            prospects.delete(q)
            prospects.each do |m|
                m.message = "reject"
            end
        end
        
        def matched?
            return 1 unless @fiance.nil?
        end
    end

    class Man
        attr_accessor :fiance
        attr_accessor :proposee
        attr_accessor :message
        attr_reader :key
        @message = ""
        
        def initialize(key, preferences)
            @fiance = nil
            @proposee = nil
            @preferences = preferences
            @key = key
        end
        
        def propose_to(woman)
            woman.proposals << self
        end
        
        def process_turn
            unless @proposee.nil? 
                if @message=="accept"
                    @fiance = @proposee
                else
                    @preferences.delete(@proposee)
                end
                @proposee = nil
            end
            unless @fiance.nil? 
                if @message=="break"
                    @preferences.delete(@fiance)
                    @fiance = nil
                end
            end
            if @fiance.nil? && !@preferences.empty?
                propose_to(@preferences.first)
            end
        end
        def matched?
            return 1 unless @fiance.nil?
        end
    end
        

    def self.match(men, women)
        return nil if men.empty? || women.empty?
        
        
        matches = Hash.new(nil)
        
        men.keys.each_with_index {|k,i| matches[k] = women.keys[i]}
        
        
        # create graph representation
        pool = []
        women.each do |w, prefs|
            men.keys.each do |m|
                prefs << m unless prefs.include? m
            end
            pool << Woman.new(w, prefs)
        end
        men.each do |m, prefs|
            women.keys.each do |w|
                prefs << w unless prefs.include? w
            end
            pool << Man.new(m, prefs)
        end
        prev_matches = 0
        curr_matches = 0
        pool.each { |x| x.process_turn }
        pool.each { |x| curr_matches += x.matched?}
        while prev_matches != curr_matches do
            prev_matches = curr_matches
            curr_matches = 0
            pool.each { |x| x.process_turn }
            pool.each { |x| curr_matches += x.matched?}
        end
        
        matches = Hash.new
        pool.each {|x| matches[x.key] = x.fiance.key}
        
        return matches
    end
end