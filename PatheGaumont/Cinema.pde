class Cinema implements Comparable {
    String nom, url, distance;
    int id;
    float lat, lon;
    float latKm, lonKm, distKm;
    float x, xtar, y;
    int couleur = 30;

    Cinema(String _nom, String _url, float _lat, float _lon, int _id) {
        nom = _nom;
        url = _url;
        if (isLocated) {
            lat = _lat;
            latKm = lat * 110.54;
            lon = _lon;
            lonKm = lon * 111.32 * cos(radians(lat));
            distKm = dist(latitudeKm, longitudeKm, latKm, lonKm);
            distance = nf(distKm, 1, 3);
            println(nom + ": " + distance + "Km");
        }
        id = _id;
        y = _id * cineHeight;

        //println(nom+"\n"+url);
        //println("");
    }

    void initDisplay() {
        x = -id*width;
        xtar = 1;
        couleur = docUrl.equals(url) ? 80 : 30;
    }

    void display() {
        x = ease(x, xtar, 0.1);
        stroke(0);
        fill(couleur);
        rect(x, scrollY+y, width, cineHeight);

        noStroke();
        fill(255);
        textAlign(LEFT, CENTER);
        text(nom, x+10, scrollY+y+cineHeight/2);
    }

    void clickOver(float _y) {
        if (_y>scrollY+y && _y<scrollY+y+cineHeight) {
            couleur = 80;
        }
        else {
            couleur = 30;
        }
    }

    void clickCine(float _y) {
        if (_y>scrollY+y && _y<scrollY+y+cineHeight) {
            couleur = 80;
            cine = nom;
            if (!docUrl.equals(url)) {
                docUrl = url;
                write_file(docUrl);
                thread("getFilmsList");
            }
            else {
                scrollYTar = 0;
                scrollY = 0;
                viewFilms = true;
                isLoading = false;
            }
        }
        else {
            couleur=0;
        }
    }

    int compareTo(Object o) {
        Cinema other=(Cinema)o;
        if (other.distKm > distKm)  
            return -1;
        else if (other.distKm == distKm)
            return 0;
        else
            return 1;
    }
};

