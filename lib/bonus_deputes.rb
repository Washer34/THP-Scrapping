require 'watir'
require 'nokogiri'
require 'open-uri'

#methode pour scrap et assembler les URLs des mairies et stockage des emails
def get_depute_urls
  # Site de base
  annuaire = Nokogiri::HTML(URI.open("https://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
  #Je scrap les url
  all_url = annuaire.xpath('//*[@id="deputes-list"]/div[*]/ul[*]/li[*]/a')
  name_depute = []
  first_names = []
  last_names = []
  suffix_email = "@assemblee-nationale.fr"
  depute_emails = []
  all_url.each do |element| #Boucle pour récup les noms
    name = element.text.strip
    # Ajoute le nom complet dans l'array name_depute
    name_depute << name
  end
  #Boucle pour séparer Nom / Prénom et assemblage de l'email sous forme prénom.nom@suffix_email
  name_depute.each do |name|
  #Je split par des espaces ce qui donne [0]Mr/Mme [1]Prénom [2]Nom
    parts = name.split(" ")
    first_names << parts[1]
    last_names << parts[-1]
  #Assemblage des emails
    depute_emails << "#{parts[1]}.#{parts[-1]}#{suffix_email}"
  end
  #Assemblage de l'array de hashs
  liste_depute = first_names.zip(last_names, depute_emails)
  annuaire_depute = []
  #Boucle pour la mise en forme pour chaque element dans la liste_depute
  liste_depute.each do |elem|
    hash = {
      "First_name" => elem[0],
      "Last_name" => elem[1],
      "Email" => elem[2]
    }
    annuaire_depute << hash
  end
  puts annuaire_depute
end
get_depute_urls