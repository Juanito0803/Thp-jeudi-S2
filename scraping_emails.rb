require 'nokogiri'
require 'open-uri'
require 'pry'

def get_all_the_urls_of_val_doise_townhalls (lien)
page = Nokogiri::HTML(open(lien))
a = 0
b = 185
tab = [""]  #Creation Tableau 1
tab2 = [""] #Creation Tableau 2
    while (a < b)
        adresse = page.css('a.lientxt')[a]['href']
        tab [a] = adresse
        tab [a] = tab[a].sub(".", "http://annuaire-des-mairies.com")
        a = a + 1
      end
        return tab
end

def get_the_email_of_a_townhal_from_its_webpage (lien)
        a = 0
        tab2 = get_all_the_urls_of_val_doise_townhalls (lien)
        tab = []
while (a < 185)
        email = Nokogiri::HTML(open(tab2[a]))
        tab[a] = email.xpath('//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
        puts tab[a]
        a = a + 1
end
    return tab
end

lien = "http://annuaire-des-mairies.com/val-d-oise.html"
puts get_the_email_of_a_townhal_from_its_webpage(lien)
