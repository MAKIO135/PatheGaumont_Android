class Film {
    int id;
    String titre, duree;
    PImage affiche;
    Horaire[] horaires;// tableau des horaires par journées à l'affiche
    String horaireString = "";
    float x, y;

    Film(Element _filmEl, int _id) {
        id = _id;
        x = filmMarge + (id%2)*filmWidth;
        y = typoSize*2 + filmMarge + (id/2)*filmHeight;

        Element titreEl = _filmEl.select("div.titre_choix > h6").first();
        titre = titreEl.ownText();
        //println(titre);

        duree = _filmEl.select("div.time").first().ownText();
        //println(duree);

        String afficheUrl = _filmEl.select("div.affiche > img").attr("abs:src");
        affiche = loadImage(afficheUrl);

        Elements dayList = _filmEl.select("li.cin-list > ul > li");
        horaires = new Horaire[dayList.size()];
        // println("horaires.length: "+horaires.length);

        int i = 0;
        for (Element dayEl : dayList) {
            horaires[i] = new Horaire(dayEl, i);
            horaireString += horaires[i].horaire + "\n";
            i++;
        }
        //println("");
    }

    void display() {
        noStroke();
        fill(255);
        image(affiche, x, scrollY+y, filmWidth - filmMarge*3/2, filmHeight - filmMarge*3/2);
    }

    void clickFilm(float _x, float _y) {
        if (_x>x && _x<x+filmWidth && _y>scrollY+y && _y<scrollY+y+filmHeight)
            KetaiAlertDialog.popup(parent, titre, (duree + "\n" + horaireString));
    }
};

