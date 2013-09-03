void onTap(float _x, float _y) {
    //println("onTap");
    if (!isLoading) {
        if (!viewFilms) { // cineView()
            for (int i=0; i<cines.length; i++) {
                cines[i].clickOver(_y);
            }
        }
        else if (viewFilms && _y > cineHeight) { // filmView()
            for (int i = 0, len = films.length; i<len; i++) {
                films[i].clickFilm(_x, _y);
            }
        }
    }
}

void onDoubleTap(float _x, float _y) {
    //println("onDoubleTap");
    if (!isLoading && clickTimer>60) {
        if (!viewFilms) { // cineView()
            for (int i=0; i<cines.length; i++) {
                cines[i].clickCine(_y);
            }
        }
        else {// filmView()
            if (_y<cineHeight) { 
                if (!cinesLoaded) thread("getCinemasList");
                else {
                    scrollYTar = 0;
                    scrollY = 0;
                    for (int i = 0, len = cines.length; i<len; i++) {
                        cines[i].initDisplay();
                    }
                    viewFilms = false;
                    isLoading = false;
                }
            }
            else {
                for (int i = 0, len = films.length; i<len; i++) {
                    films[i].clickFilm(_x, _y);
                }
            }
        }
        clickTimer = 0;
    }
}

void onLongPress(float _x, float _y) {
    //println("onLongPress");
    if (!isLoading && clickTimer>60) {
        if (!viewFilms) { // cineView()
            for (int i=0; i<cines.length; i++) {
                cines[i].clickCine(_y);
            }
        }
        else {// filmView()
            if (_y<cineHeight) { 
                if (!cinesLoaded) thread("getCinemasList");
                else {
                    scrollYTar = 0;
                    scrollY = 0;
                    for (int i = 0, len = cines.length; i<len; i++) {
                        cines[i].initDisplay();
                    }
                    viewFilms = false;
                    isLoading = false;
                }
            }
            else {
                for (int i = 0, len = films.length; i<len; i++) {
                    films[i].clickFilm(_x, _y);
                }
            }
        }
        clickTimer = 0;
    }
}

//these still work if we forward MotionEvents below
void mouseDragged() {
    if (!isLoading) {
        scrollYTar += mouseY - pmouseY;
        if (!viewFilms) scrollYTar = constrain(scrollYTar, -(cines.length * cineHeight - height), 0);
        else scrollYTar = constrain(scrollYTar, -(cineHeight + filmMarge*2 + ceil(films.length/2.) * filmHeight - height), 0);
    }
}

void mouseReleased() {
    if (!isLoading) {
        scrollYTar += (mouseY - pmouseY) * 30;
        if (!viewFilms) scrollYTar = constrain(scrollYTar, -(cines.length * cineHeight - height), 0);
        else scrollYTar = constrain(scrollYTar, -(cineHeight + filmMarge*2 + ceil(films.length/2.) * filmHeight - height), 0);
    }
}

public boolean surfaceTouchEvent(MotionEvent _event) {
    //call to keep mouseX, mouseY, etc updated
    super.surfaceTouchEvent(_event);

    //forward event to class for processing
    return gesture.surfaceTouchEvent(_event);
}
