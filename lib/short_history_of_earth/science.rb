class ShortHistoryOfEarth::Science
  attr_accessor :data_array, :billion_array, :million_array
  
  def initialize 
      @last_response=nil
  end
  
  def self.last_response
      @last_response
  end
  
  def self.scrape_timeline
    doc=Nokogiri::HTML(open("http://www.julesberman.info/chronos.htm"))
    @info_array=doc.css("body").first.text
  end

  def self.format_data_into_arrays
    scrape_timeline
    @info_array=@info_array.split("\n")
    @info_array.select! do |year|
         year[0].to_i.between?(1,9) || year[0]=="-"
             end
    @data_hash={}
    @billion_hash={}
    @million_hash={}
    @info_array.each do |year|
      array_for_hash=year.split("=>")
      if array_for_hash[0].include? "billion"
        @billion_hash[array_for_hash[0]]= year
      elsif array_for_hash[0].include? "million"
        @million_hash[array_for_hash[0]]= year
      else
        @data_hash[array_for_hash[0]]= year
      end
                    end
    @billion_array=@billion_hash.sort{|a,b| a[0].to_i<=>b[0].to_i} 
    @million_array=@million_hash.sort{|a,b| a[0].to_i<=>b[0].to_i}
    @data_array=@data_hash.sort{|a,b| a[0].to_i<=>b[0].to_i}
    integrate_maya_data
  end
  
  def self.integrate_maya_data
     @maya_array=ShortHistoryOfEarth::Maya.organize_maya_data
     @maya_array.each do |maya_event|
        @data_array << maya_event
                   end
    @data_array.sort!{|a,b| a[0].to_i <=> b[0].to_i}
  end
  
  def self.compare_answer_given_with_data_hash
      format_data_into_arrays
      @normalized_response=ShortHistoryOfEarth::Next_Control.normalize_response
     if @normalized_response.include? "billion"
       compare_billions
     elsif @normalized_response.include? "million"
       compare_millions
     else
         compare_data
     end
  end
  
  def self.compare_billions
    @billion_array.each do |event|
          changed_event_date=event[0].split.join(" ")
          altered_event_date=event[0].gsub(/[^\d,-.]/,"")
          @altered_normalized_response=@normalized_response.gsub(/[^\d,-.]/,"")
         if changed_event_date==@normalized_response
           @last_response=event[0]
           puts event[1]
           return 
         elsif altered_event_date.to_i>@altered_normalized_response.to_i
           puts event[1]
           if altered_event_date=="-1.2"
             @last_response="-601 million"
           else
             @last_response=event[0]
           end
           return
         elsif altered_event_date=="-1.2"
           puts event[1]
           @last_response="-601 million"
           return
         end
                    end
  end
  
  def self.compare_millions
        @million_array.each do |event|
          changed_event_date=event[0].split.join(" ")
          altered_event_date=event[0].gsub(/[^\d,-.]/,"")
          @altered_normalized_response=@normalized_response.gsub(/[^\d,-.]/,"")
          if changed_event_date==@normalized_response
              puts event[1]
              @last_response=event[0]
              return
          elsif altered_event_date.to_i>@altered_normalized_response.to_i
             puts event[1]
             if altered_event_date=="-2.5"
               @last_response="-500001"
             else
               @last_response=event[0]
             end
             return
          elsif altered_event_date=="-2.5"
             puts event[1]
             @last_response="-500001"
             return
          end
                            end 
  end
  
  def self.compare_data
       @data_array.each_cons(2) do |event|
          changed_event_date=event[0][0].split.join
          if changed_event_date==@normalized_response 
              puts event[0][1]
                if event[0][0]==event[1][0].split.join
                  puts event[1][1]
                end
              @last_response=event[0][0]
              return
          elsif event[0][0].to_i>@normalized_response.to_i
              puts event[0][1]
                if event[0][0]==event[1][0].split.join
                  puts event[1][1]
                end
              @last_response=event[0][0]
              return
          end
                   end

  end
    
    
end