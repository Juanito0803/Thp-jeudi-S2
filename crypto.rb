require 'rubygems'
require 'open-uri'
require 'nokogiri'

def va_chercher_les_cryptos #creation methode pour récupérer toutes les cryptomonnaies.

@array1 = [] # premier array pour tableau vide

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
page.css('a.currency-name-container').each do |check|
@array1 << check.text # va ajouter dans l'array 1 les devises
end

end

def va_chercher_la_valeur #creation methode pour récupérer les valeurs

@array2 = [] # deuxieme array pour tableau vide

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
page.css('a.price').each do |check|
@array2 << check.text # va ajouter dans l'array les valeurs
 end

end
def timer # Pour relancer le programme chaque heure
   while true # boucle infini pour répéter le programme chaque heur
      va_chercher_les_cryptos  # va lancer la premiere methode
      va_chercher_la_valeur #va lancer la deuxieme methode
      puts Hash[@array1.zip(@array2)] #hash (fusion des deux arrays (1 et 2))

      sleep 3600 # attend 3600 sec pour se relancer (3600 secondes = 1h)
   end
end

timer #pour lancer le timer
