void getCinemasList() {
    //println("Loading Cinemas List");
    isLoading = true;
    loadingX = 0;
    loadingXTar = 0;

    try {
        doc = Jsoup.connect(docUrl).get();
        Element bloc_villes = doc.select("div.bloc_villes > script").first();
        String[] cineList = splitTokens(bloc_villes.html(), "\n");
        cines = new Cinema[cineList.length];
        //println("Nb Cines: " + cines.length);

        int i = 0;
        for (String s : cineList) {
            String nom=null, url=null;
            float lat, lon;
            String[] t = splitTokens(s, ",\"");
            nom = t[2];
            lat = Float.parseFloat(t[3]);
            lon = Float.parseFloat(t[4]);
            url = t[5];

            // println(nom+"\n"+url);
            // println("");
            cines[i] = new Cinema(nom, url, lat, lon, i);
            i++;
            loadingXTar = i * loadWidth/cines.length;
        }

        cinesLoaded = true;

        if (isLocated) {
            Arrays.sort(cines);
        }

        scrollYTar = 0;
        scrollY = 0;
        for (int j = 0, len = cines.length; j<len; j++) {
            if (isLocated) {
                cines[j].id = j;
                cines[j].y = j * cineHeight;
            }
            cines[j].initDisplay();
        }
        viewFilms = false;
        isLoading = false;
    }
    catch (IOException e) {
        println(e.getMessage());
        thread( "getCinemasList" );
    }
}

void getFilmsList() {
    //println("Loading Films List");
    isLoading = true;
    loadingX = 0;
    loadingXTar = 0;

    try {
        doc = Jsoup.connect(docUrl).get();
        Elements filmList = doc.select("div.liste_blocs_films > div.film");
        films = new Film[filmList.size()];
        //println("Nb Films: " + films.length);

        int i = 0;
        for (Element filmEl : filmList) {
            films[i] = new Film(filmEl, i);
            i++;
            loadingXTar = i * loadWidth/films.length;
        }

        scrollYTar = 0;
        scrollY = 0;
        viewFilms = true;
        isLoading = false;
    }
    catch (IOException e) {
        println(e.getMessage());
        thread( "getFilmsList" );
    }
}

