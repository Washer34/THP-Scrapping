require 'watir'
require 'nokogiri'
require 'selenium-webdriver'
require 'webdrivers'

def perform
  # Ouvre la page dans Watir
  browser = Watir::Browser.new :chrome, headless: true #headless : true = n'ouvre pas le navigateur
  browser.goto('https://coinmarketcap.com/all/views/all/')
  # Scroll jusqu'à la fin de la page en petits incréments
  16.times do
    browser.send_keys(:space)
    sleep 0.1
  end

  # Parse la page dans Nokogiri
  page = Nokogiri::HTML.parse(browser.html)
  #Scrap les monnaies et leurs valeurs
  all_currencies = page.xpath('//tr[*]/td[3]/div')
  all_values = page.xpath('//tr[*]/td[5]/div/a/span')
  # Ferme le navigateur
  browser.close
  # On ne récupère que le text
  name_array = all_currencies.map{ |coin| coin.text}
  value_array = all_values.map {|value| value.text.gsub("$", "").gsub(",", "").to_f}

  #On zip les noms et les valeurs en hash qu'on met dans un array: 
  currencies = name_array.zip(value_array).map {|name, value| {name => value }}
  return currencies
end

perform
