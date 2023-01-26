require 'nokogiri'
require 'open-uri'

Page = Nokogiri::HTML(URI.open('https://www2.assemblee-nationale.fr/deputes/liste/tableau'))

scrap_name = Page.xpath('//tbody/tr/td[1]//a').map{|i| i.text.split}
name_without_mr = scrap_name.each{|j| j.shift}



# Methode pour avoir chaque lien correspondant a un député
    test2 = Page.xpath('//tbody/tr/td[1]//a/@href').map{|j| j.text.split}
    test2.map!{|k| (k.unshift("https://www2.assemblee-nationale.fr")).join("")}
    test2

#Methode pour avoir les adresses mails
a = 0
arr4 = []
test2.each do |j|

    page_deputy = Nokogiri::HTML(URI.open(j))
    arr4 << page_deputy.xpath('////*[@id="main"]/div/div/div/section[2]/div/ul/li[1]/a/span[2]').text
    p " #{arr4.length/Page.xpath('//tbody/tr/td[1]//a').length.to_f*100} % completed"

end


#Print chaque hash

name_without_mr.length.times do |i|
    hash = Hash.new
     hash["first_name"] = name_without_mr[i][0]
     hash["last_name"] = name_without_mr[i][1]
     hash["e-mail"] = arr4[i]
    p hash
    end

