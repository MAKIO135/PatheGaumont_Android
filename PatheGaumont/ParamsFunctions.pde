////////////////////////////////////////////////chargement des paramètres
void loadParams() {
    if ( ( new File( sketchPath + "/Param.txt" ) ).exists() ) {
        //println( "User file exists" );
        try {
            user_data = new FileWriter( sketchPath + "/Param.txt", true );
            bw = new BufferedWriter( user_data );
            exists_flag = true;
            //println( exists_flag );
        }
        catch(IOException e) {
            println( "Exception at existing file edit: " + e );
            exists_flag = false;
            //println( exists_flag );
        }
        read_file();
    }
    else {
        try {
            user_data = new FileWriter( sketchPath + "/Param.txt" );
            exists_flag = true;
        }
        catch( IOException e ) {
            println( "Exception at new file creation: " + e );
            exists_flag = false;
        }
        if ( exists_flag ) {
            println( "Creating new player file: " + user_data );
            loadParams();
        }
    }
}

////////////////////////////////////////////////lecture des paramètres
void read_file() {
    //println( "reading Parameters" );

    try {
        //println("sketchPath: " + sketchPath);
        fro = new FileReader( sketchPath+"/Param.txt" );
        bro = new BufferedReader( fro );

        // declare String variable and prime the read
        String stringRead = bro.readLine();
        if ( stringRead == null ) {
            //println( "no param found" );
            docUrl = "http://www.cinemasgaumontpathe.com/cinemas/cinema-pathe-lyon-cordeliers/";
            write_file(docUrl);
            //println(docUrl);
            thread( "getCinemasList" );
        }
        else {
            /*while ( stringRead != null ){ // end of the file
                println( stringRead );
                stringRead = bro.readLine();    // read next line
            }*/
            docUrl = stringRead;
            String[] temp=split(docUrl,'/');
            cine = join(subset(split(temp[4],'-'),1),' ').toUpperCase();
            //println(cine);
            //println( docUrl );
            thread( "getFilmsList" );
        }
        bro.close();
    }

    catch( IOException e ) {
        println( "Exception at readfile: " + e );
    }
}

////////////////////////////////////////////////écriture des paramètres
void write_file( String _url ) {
    //println( "write" );
    try {
        user_data = new FileWriter( sketchPath+"/Param.txt" );
        bw.write( _url );
        bw.flush();
    }
    catch( IOException e ) {
        println( "Exception at write file: "+e );
    }
}

