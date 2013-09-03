class Horaire {
    String horaire = "";
    String date;
    String[] versions;
    String[] heures;
    boolean vide = true;
    boolean[] versionsVide;

    Horaire(Element _dayEl, int _id) {
        String[] splitClass = splitTokens(_dayEl.className(), " _-");
        date = splitClass[splitClass.length-1] + "/" + splitClass[splitClass.length-2] + "/" + splitClass[splitClass.length-3];
        // println("\t" + _id + ". " + date);

        Elements versionsEl = _dayEl.select("li.sceance-reserver:has(div.version)");
        versions = new String[versionsEl.size()];
        versionsVide = new boolean[versionsEl.size()];
        heures = new String[versionsEl.size()];

        int i = 0;
        for (Element versionEl : versionsEl) {
            versions[i] = versionEl.select("div.version > strong").text();
            // print("\t" + versions[i] + ": ");

            Elements heuresEl = versionEl.select("a.bulle-horaire");
            heures[i] = "";
            versionsVide[i] = true;
            int j = 0;
            for (Element heureEl : heuresEl) {
                if ( (_id == 0 && match(heureEl.parent().className(), "locked") == null) || _id!=0 ) {
                    heures[i] += heureEl.ownText() + " ";
                    versionsVide[i] = false;
                    vide = false;
                }
                j++;
            }
            // println(" " + heures[i]);
            i++;
        }

        if (!vide) {
            //println("\t" + date);
            horaire += "\n" + date;
            for (int k = 0, len = versions.length; k<len; k++) {    
                if (!versionsVide[k]) {
                    //println("\t" + versions[k] + ": " + heures[k]);
                    horaire += "\n" + versions[k] + ": " + heures[k];
                }
            }
        }
    }
};
