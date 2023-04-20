require 'watir'
require 'nokogiri'
require 'open-uri'

#methode pour scrap les emails sur les sites des mairies
def get_townhall_emails(townhall_urls)
  email = Nokogiri::HTML(URI.open(townhall_urls))
  emails = email.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
  return emails
end

#methode pour scrap et assembler les URLs des mairies et stockage des emails
def get_townhall_urls
  # Site de base
  annuaire = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))
  #Je scrap les url
  all_url = annuaire.xpath('//a[@class="lientxt"]/@href') 
  #Je mets en forme les urls
  all_urls = all_url.map(&:value).map{|elem| elem.gsub(/^\./, '')} 
  #Je mets en forme les noms
  all_names = all_urls.map{|town| town.gsub(/^\/95\/|\.html$/, '').upcase } 
  global_site = "http://annuaire-des-mairies.com"
  #Array pour stock les URLs des mairies
  townhall_sites = [] 
  #Array pour stock les emails des mairies
  all_emails = [] 
  #boucle pour assembler le global_site avec les urls des mairies
  all_urls.length.times do |town| 
    townhall_sites = global_site + "#{all_urls[town]}" 
    #on appelle la deuxième fonction pour scrap les mails
    all_emails << get_townhall_emails(townhall_sites) 
  end
  #On zip les noms et les valeurs en hash qu'on met dans un array: 
  annuaire_final = all_names.zip(all_emails).map {|names, emails| {names => emails }}
  puts annuaire_final.inspect
  return annuaire_final  
end

get_townhall_urls