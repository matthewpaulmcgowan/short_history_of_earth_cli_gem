class ShortHistoryOfEarth::Science
  attr_accessor :data_array, :billion_array, :million_array, :info_array
  
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

  def self.strip_raw_data
    scrape_timeline
    @info_array=@info_array.split("\n")
    @info_array.select! do |year|
      year[0].to_i.between?(1,9) || year[0]=="-"
                         end
  end
  
  def self.format_data_into_arrays
    strip_raw_data
    @data_array=[]
    @billion_array=[]
    @million_array=[]
    @info_array.each do |year|
      split_year_array=year.split("=>")
      if split_year_array[0].include? "billion"
        @billion_array << [split_year_array[0],year]
      elsif split_year_array[0].include? "million"
        @million_array << [split_year_array[0],year]
      else
        @data_array << [split_year_array[0],year]
      end
                    end
    sort_hash_or_array(@billion_array) 
    sort_hash_or_array(@million_array)
    sort_hash_or_array(@data_array)
    integrate_maya_data
  end
  
  def self.sort_hash_or_array(hash_or_array)
   hash_or_array.sort!{|a,b| a[0].to_i<=>b[0].to_i}
  end
  
  def self.integrate_maya_data
     @maya_array=ShortHistoryOfEarth::Maya.organize_maya_data
     @maya_array.each do |maya_event|
        @data_array << maya_event
                   end
     sort_hash_or_array(@data_array)
  end
  
  def self.compare_answer_given_with_data_hash
      format_data_into_arrays
      @normalized_response=ShortHistoryOfEarth::Next_Control.normalize_response
     if @normalized_response.include? "billion"
       compare_billion_or_million(@billion_array,"-1.2","-601 million")
     elsif @normalized_response.include? "million"
       compare_billion_or_million(@million_array,"-2.5","-500001")
     else
         compare_data
     end
  end
  
  def self.compare_billion_or_million(billion_or_million_array,youngest_event_in_category,jump_to_date_for_next_category)
      billion_or_million_array.each do |event|
          changed_event_date=event[0].split.join(" ")
          altered_event_date=event[0].gsub(/[^\d,-.]/,"")
          @altered_normalized_response=@normalized_response.gsub(/[^\d,-.]/,"")
          if changed_event_date==@normalized_response
              puts event[1]
              @last_response=event[0]
              return
          elsif altered_event_date.to_i>@altered_normalized_response.to_i
             puts event[1]
             if altered_event_date==youngest_event_in_category
               @last_response=jump_to_date_for_next_category
             else
               @last_response=event[0]
             end
             return
          elsif altered_event_date==youngest_event_in_category
             puts event[1]
             @last_response=jump_to_date_for_next_category
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