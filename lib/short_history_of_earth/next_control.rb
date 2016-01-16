class ShortHistoryOfEarth::Next_Control
  
  def self.next_item
    @response=ShortHistoryOfEarth::CLI.response
    @last_response=ShortHistoryOfEarth::Science.last_response
    if !/\d/.match(@response)
      @response="next"
    end
    if @response.downcase =="next"
      if @last_response==nil 
        @response="-15 billion"
      else
        @last_response=@last_response.split
        changed_response_array=[]
        @last_response[0..1].each do |segment|
          if /\d/.match(segment)
            segment=segment.to_i+1
            segment=segment.to_s
          end
          changed_response_array << segment
                          end
        @response=changed_response_array.join(" ")
      end
    end
  end
  
  def self.normalize_response
    next_item
    @normalized_response=@response.downcase
    @normalized_response=@normalized_response.gsub("billions","billion").gsub("millions","million")
    if @normalized_response[0]!="-"
      if @normalized_response.include? "billion"
        @normalized_response=@normalized_response.insert(0,"-")
      elsif @normalized_response.include? "million"
        @normalized_response=@normalized_response.insert(0,"-")
      elsif @normalized_response.split.all?{|segment|/\d/.match(segment)}
        if @normalized_response.to_i>2000
          @normalized_response=@normalized_response.insert(0,"-")
        end
      end
    end
    filtered_response=[]
    @normalized_response.split.each do |segment|
      if segment =="billion"||segment=="million"||/\d/.match(segment)
        filtered_response << segment
      end
                                    end
    @normalized_response=filtered_response.join(" ")
  end
    
end
    