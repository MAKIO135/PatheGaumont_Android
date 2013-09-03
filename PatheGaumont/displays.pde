/////////////////////////////////////////////// loading
void initLoading() {
    loadWidth = width/2;
    loadX = width/4;
    loadY = height/2 + typoSize/2;
    logo = loadImage("logo.png");
    logoW = int(constrain(logo.width,width/2,9*width/10));
    logoH = logo.height * logoW/logo.width;
    mk135 = loadImage("MK135.png");
    mk135W = int(constrain(mk135.width,width/2,9*width/10));
    mk135H = mk135.height * mk135W/mk135.width; 
}
void loading() {
    imageMode(CENTER);
    image(logo, width/2, height/4, logoW, logoH);
    image(mk135, width/2, 3*height/4, mk135W, mk135H);
    
    fill(255);
    textAlign(CENTER, CENTER);
    text("CHARGEMENT...", width/2, (height-typoSize)/2);

    stroke(255);
    noFill();
    rect(loadX, loadY, loadWidth, 7);

    fill(255);
    loadingX = ease(loadingX, loadingXTar, 0.5);
    rect(loadX, loadY, loadingX, 7);
}

/////////////////////////////////////////////// cineView
void cineView() {
    for (int i = 0, len = cines.length; i<len; i++) {
        cines[i].display();
    }
}

/////////////////////////////////////////////// filmView
void filmView() {
    imageMode(CORNER);
    
    for (int i = 0, len = films.length; i<len; i++) {
        films[i].display();
    }
    
    noStroke();
    fill(30);
    rect(0, 0, width, cineHeight);

    noStroke();
    fill(255);
    textAlign(LEFT, CENTER);
    text(cine, 10, cineHeight/2);
}

float ease(float variable, float target, float easingVal) {
    float d = target - variable;
    if (abs(d)>1) variable+= d*easingVal;
    return variable;
}

