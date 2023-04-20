require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(URI.open("ton_url_a_scrapper.com"))
all_emails_links = page.xpath('/mettre_ici_le_XPath') 
# Exemple pour recup tous les liens : "page.xpath('//a')"
# Pour tous les titres "page.xpath('//h1')"
# Pour TOUS les éléments HTML situés DIRECTEMENT sous un h1 "page.xpath('//h1/*')"
# Pour le lien ayant l'id email situé sous un h1 de classe primary "page.xpath('//h1[@class="primary"]/a[@id="email"]')"
# Pour tous les liens dont le href contient le mot "mailto" "page.xpath('//a[contains(@href, "mailto")]')"

# Pour récupérer le texte de chaque lien ? Il faut parcourir l'array et extraire le .text de chaque élément HTML :
#all_emails_links.each do |email_link|
#  puts email_link.text #ou n'importe quelle autre opération au choix
#  end
#Tu peux aussi récupérer le texte du href d'un élément HTML avec email_link['href']