class ShortHistoryOfEarth::Maya
   attr_accessor :maya_array
   
   def self.maya_scraper
       doc=Nokogiri::HTML(open("http://www.historymuseum.ca/cmc/exhibitions/civil/maya/mmc09eng.shtml"))
       @maya_array=[]
       doc.css(".civ").css("dt").each do |time|
           if time.text.include?"B"
            
           elsif time.text.include?"A"
           
           else
             @maya_array << [time.text]
           end
                                    end
        doc.css(".civ").css("dd").each_with_index do |event,i|
          @maya_array[i] << event.text
                                       end
   end
   
    def self.organize_maya_data
        maya_scraper
      @maya_array.map! do |segment|
       segment.map! do |mini|
        mini=mini.gsub("\r\n","")
                        end    
                    end
      @maya_array.collect.with_index do |part,i|
           if i<9
             part[0]=part[0].insert(0,"-")
           end
           if part[0].split.length >1
               part[0]=part[0].split[0]
           end
           part[0]=part[0].gsub(",","")
           maya_format=part[1]
           part[1]="#{part[0]} => #{maya_format}"
                        end
     @maya_array
    end

    def self.all_maya_info
      organize_maya_data
      @maya_array.each do |maya_event|
        puts maya_event[1]
                        end
      return
    end
    
end