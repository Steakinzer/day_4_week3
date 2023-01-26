# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

Page = Nokogiri::HTML(URI.open('https://coinmarketcap.com/all/views/all/'))

def scrap_value(page)
  valeurs = page.xpath('//td[@class= "cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price"]')
  arr1 = []
  valeurs.each do |i|
    arr1 << i.text
  end
  arr1
end

def scrap_name(page)
  name = page.xpath('//td[@class= "cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--hide-sm cmc-table__cell--sort-by__symbol"]')
  arr2 = []
  name.each do |j|
    arr2 << j.text
  end
  arr2
end

def to_hhash(array1, array2)
  Hash[array1.zip(array2)]
end

hashi = to_hhash(scrap_name(Page), scrap_value(Page)).to_a
final_hash = []
hashi.length.times { |_l| final_hash << [] }
final_hash.length.times { |m| final_hash[m] << to_hhash(scrap_name(Page), scrap_value(Page)).to_a[m] }
final_hash.map!(&:to_h)
p final_hash

# p final_hash
# crypto = Hash[scrap_name(page).zip(scrap_value(page))]
