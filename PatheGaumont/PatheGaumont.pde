///////////////////////////////////////////////touch events
import android.view.MotionEvent;
import ketai.ui.*;
KetaiGesture gesture;

///////////////////////////////////////////////position
import ketai.sensors.*; 
float longitude, latitude, longitudeKm, latitudeKm;
boolean isLocated = false;

////////////////////////////////////////////////////lecture & écriture des paramètres
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.File;
import java.io.BufferedReader;
import java.io.FileReader;
FileWriter user_data;
BufferedWriter bw;
FileReader fro;
BufferedReader bro;
boolean exists_flag = false;

///////////////////////////////////////////////Jsoup HTML Parser
import org.jsoup.Jsoup;
import org.jsoup.nodes.*;
import org.jsoup.select.*;
Document doc = null;
String docUrl;

///////////////////////////////////////////////
import java.util.*;

int typoSize;
int clickTimer = 20; // timer entre 2 long press/double click
boolean viewFilms = true;
String cine;
float scrollY = 0, scrollYTar = 0;

boolean isLoading = true;
float loadWidth, loadX, loadY, loadingX = 0, loadingXTar = 0;
PImage logo, mk135;
int logoW, logoH, mk135W, mk135H;

Cinema[] cines;
boolean cinesLoaded = false;
float cineHeight;

Film[] films;
PApplet parent;
float filmMarge, filmWidth, filmHeight;

void setup() {
    orientation(PORTRAIT);

    typoSize = width/20;
    textSize(typoSize);
    parent = this;
    cineHeight = typoSize*2.5;
    filmMarge = width/100;
    filmWidth = width/2;
    filmHeight = 2*width/3;

    gesture = new KetaiGesture(this);
    
    KetaiLocation location = new KetaiLocation(this);
    if (location.getProvider() == "none"){
        isLocated = false;
        //println("no location found");
    }
    else{
        isLocated = true;
        Location l = location.getLocation();
        latitude = (float)l.getLatitude();
        latitudeKm = latitude * 110.54;
        longitude = (float)l.getLongitude();
        longitudeKm = longitude*111.32*cos(radians(latitude));
        //println("lat/lon: " + latitude + "/" + longitude);
    }

    initLoading();
    thread("loadParams");
}

void draw() {
    background(0);

    if (isLoading) {
        loading();
    }
    else {
        scrollY = ease(scrollY, scrollYTar, 0.1);

        if (viewFilms) {
            filmView();
        }
        else {
            cineView();
        }
    }

    clickTimer++;
    if (clickTimer > 200) {
        clickTimer = 100;
    }
}

