class ShortHistoryOfEarth::Bernes
    def self.jules_bernes
        puts "Jules Bernes"
    end
    
    def self.bio_of_jules_berman_scraper
      doc=Nokogiri::HTML(open("http://www.amazon.com/Jules-J.-Berman/e/B001IZPQCI"))
      @bio_info=doc.css("#ap-bio").text
    end

    def self.bio_of_jules_berman
      bio_of_jules_berman_scraper
      @bio_info=@bio_info.split.join(" ").gsub(" more","").gsub("See","")
      puts @bio_info
      puts "And his website is http://www.julesberman.info/chronos.htm"
    end
    
end