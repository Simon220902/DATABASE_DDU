import controlP5.*;

class ScreenManager{
  ArrayList<Screen> screens;
  
  ScreenManager(){
    screens = new ArrayList<Screen>();
  }
  void addScreen(Screen s){
    //If the screen is not in screens we add it
    if (screens.indexOf(s) == -1){
      screens.add(s);
    }
  }
}
