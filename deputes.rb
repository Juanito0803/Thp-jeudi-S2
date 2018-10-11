require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

@prenom = [] #Correspond à first_name dans la consigne
@nom_de_famille = [] #Correspond à first name dans la consigne


def va_chercher_le_nom
  names = []
    page = Nokogiri::HTML(open('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=576'))
    page.css('h2[class = titre_normal]').each do |nom| #Code source page
    names << nom.text #<< pour ajouter a la fin du tableau
  end

names.map! { |objet| objet.delete_prefix("M ") } # Pour supprimer Monsieur https://blog.bigbinary.com/2017/11/28/ruby-2-5-added-delete_prefix-and-delete_suffix-methods.html
names.map! { |objet| objet.delete_prefix("Mme ") } # idem que la haut pour supprimer Madame
names.each { |objet| array = objet.split(" ") # pour fusionner les deux

@prenom << array[0]
@nom_de_famille << array.drop(1).join(" ") # << idem pour rajouter à la fin du tableau. # Drop pour supprimer les elements de l'array et retourner le reste sur le tableau
}
# Ci dessous le drop va supprimer les prefix et renvoyer à la valeur de départ
end
va_chercher_le_nom
# ci dessus fin de la première methode pour aller chercher les noms
# ci dessous on passe à la deuxieme methode pour aller chercher l'adresse email

def va_chercher_emails
  mail = []

    page = Nokogiri::HTML(open('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=600')) # On a modifié l'url car la liste n'était que de 50 par 50.
    page.css('a[@href ^="mailto:"]').each do |email| #code sur mail copier coller Xpath (Voir lien StackOverflow pour solution https://stackoverflow.com/questions/38821059/what-is-the-rails-way-equivalent-of-mailto-and-tel)
    mail << email.text.sub(" ", "") #remplacer les espaces par aucun espace, on aurait pu utiliser aussi gsub mais meme effet car un seul caractere a modifier https://stackoverflow.com/questions/6766878/what-is-the-difference-between-gsub-and-sub-methods-for-ruby-strings

  end
  return mail
end
va_chercher_emails

def hash_final
 hash = Hash[va_chercher_le_nom.zip(va_chercher_emails)]
 hash.each do |name, emails|
   puts "#{name} : #{emails}" #le #{} sert a rajouter du coded Ruby dans une chaine.
   #La ligne ci dessus va permettre d'afficher : Nom du député; espace; deux points; espace ; email du député.
 end
end
hash_final
