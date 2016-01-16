class ShortHistoryOfEarth::CLI

    def call
      puts "Welcome!"
      puts "I'm happy you have decided to learn a little about the history of the world"
      puts "The information is sorted by date, and focuses on early geological events and the development of humans,science, and technology."
      puts "There are also some bonus facts about Maya history!"
      puts "At any time, you can enter 'next' to move to the next referenced event."
      puts "Here are some examples of queries to search the timeline"
      puts "For billions of years ago:-14 billion"
      puts "For millions of years ago:-300 million"
      puts "For dates B.C.E. (before common era):-3000"
      puts "For date C.E. (common era):1994"
      puts "Enter 'exit' at any time to leave the archive"
      puts "Please enter a year to get started!"
      @@response=gets.strip
      match_or_exit
    end
    
    def self.response
      return @@response
    end
    
    def match_or_exit
       if @@response.downcase=="exit"
        goodbye
       elsif @@response.downcase=="maya"
         maya_info
         next_response
       else
        ShortHistoryOfEarth::Science.compare_answer_given_with_data_hash
        next_response
       end
    end
     
    def goodbye
      puts "Awesome new knowledge"
      puts "The maya information was found at http://www.historymuseum.ca/cmc/exhibitions/civil/maya/mmc09eng.shtml"
      puts "All other information was collated by Dr. Jules Berman, below is his website and a short biography!"
      ShortHistoryOfEarth::Bernes.bio_of_jules_berman
      abort
    end
    
    def maya_info
      ShortHistoryOfEarth::Maya.all_maya_info
    end
    
    def next_response
      puts "Please enter the next year you would like to jump to or simply enter 'next'!"
      @@response=gets.strip
      match_or_exit
    end
    
end