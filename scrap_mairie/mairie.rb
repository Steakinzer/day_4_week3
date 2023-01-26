# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
# Attrape uniquement le mail de avernes
# Page_avernes = Nokogiri::HTML(URI.open('https://www.annuaire-des-mairies.com/95/avernes.html'))
# def get_townhall_email (page)
#  email_avernes = page.xpath('//section[2]/div/table/tbody/tr[4]/td[2]')
#  email_avernes.text
# return email_avernes.text
# end

# get_townhall_email(Page_avernes)

# Attrape les liens des mairies
Page_links = Nokogiri::HTML(URI.open('https://www.annuaire-des-mairies.com/val-d-oise.html'))
def get_townhall_urls(page)
  links = page.xpath('//*[@class="lientxt"]/@href')
  list = []
  links.each do |mairie|
    list << mairie.text
  end
  list.map! { |url| url.sub(/^./, 'https://www.annuaire-des-mairies.com') }
  list
end

get_townhall_urls(Page_links)

def name_of_mairie(page)
  arr2 = []
  get_townhall_urls(page).length.times do |j|
    arr2 << get_townhall_urls(page)[j].gsub!('https://www.annuaire-des-mairies.com/95/', '').chomp('.html').capitalize
  end
  arr2
end

name_of_mairie(Page_links)

def all_mail(page_links)
  arr1 = []
  get_townhall_urls(page_links).length.times do |i|
    test = Nokogiri::HTML(URI.open(get_townhall_urls(page_links)[i]))
    arr1 << test.xpath('//section[2]/div/table/tbody/tr[4]/td[2]').text
  end
  arr1
  arr1
end
# Donne un array de tous les emails
all_mail(Page_links)

hashi = Hash[name_of_mairie(Page_links).zip(all_mail(Page_links))].to_a

empty_array = []
get_townhall_urls(Page_links).length.times do |_m|
  empty_array << []
end
empty_array

empty_array.length.times do |k|
  empty_array[k] << hashi[k]
end
final_array = empty_array.map!(&:compact).reject(&:empty?)
p final_array.map!(&:to_h)

#  hashi = Hash[get_townhall_urls(Page_links).zip(all_mail(Page_links))]

# arr4 =[]
# get_townhall_urls(page_links).length.times do |i|
# arr4 <<

# arr3 =[]
# get_townhall_urls(Page_links).length.times do |k|
#     arr3.map!{|k| arr3[k] << []}
#     end
#     p arr3

# def scrap_mail (page2)
#     page2.xpath('//section[2]/div/table/tbody/tr[4]/td[2]').text
# end
# arr1 =[]
# get_townhall_urls(Page_links).length.times |i|
# arr1 << scrap_mail(get_townhall_urls(Page_links)[i])
# p arr1
