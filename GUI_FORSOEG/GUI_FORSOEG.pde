/*
OK jeg tror jeg har fundet ud af det!!
VI BRUGER CONTROLP5 med dets grupper.
Hvor vi så bare kan HIDE de ting vi ikke vil have vist og de ting vi gerne vil have shower vi bare.

Så de forskellige skærmer og ting og sager er bare controlp5 groups, hvor de forskellige elementer er i WUHHUU

Hvor beskederne så bare er ene ListBox.
Hvis det er kan vi bare lave to en for hver.
Hvor den så er tom hos den ene, hvis det er den anden der har sendt en besked.
Hvor vi så bare kan "connecte" deres sliders, hvor hver gang den ene opdatere sætter vi den anden til den samme værdi da de på alle måder er ens (hvor vi så måske bare kan gemme den til venstres, hvis scroll baren er til højre)


*/

/**
* ControlP5 Group
*
*
* find a list of public methods available for the Group Controller
* at the bottom of this sketch.
*
* by Andreas Schlegel, 2012
* www.sojamo.de/libraries/controlp5
*
*/


import controlP5.*;

ControlP5 cp5;

void setup() {  
  size(700,400);

  cp5 = new ControlP5(this);
  
  Group g1 = cp5.addGroup("g1")
                .setPosition(100,100)
                .setBackgroundHeight(200)
                .setBackgroundColor(color(255,50))
                .hideBar()
                ;
                     
  cp5.addBang("A-1")
     .setPosition(10,20)
     .setSize(80,20)
     .setGroup(g1)
     ;
          
  cp5.addBang("A-2")
     .setPosition(10,60)
     .setSize(80,20)
     .setGroup(g1)
     ;
     
  cp5.addSlider("S-1-1")
     .setPosition(10,100)
     .setSize(80,20)
     .setGroup(g1)
     ;
  ListBox l;
  l = cp5.addListBox("myList")
         .setPosition(10, 130)
         .setSize(80, 60)
         .setItemHeight(20)
         .setColorBackground(color(255, 128))
         .setColorActive(color(0))
         .setColorForeground(color(255, 100,0))
         .setBarVisible(false)
         .setGroup(g1)
         ;
  for (int i=0;i<80;i++) {
    ListBox lbi = l.addItem("BESKED "+i, i);
  }
  
  Group g2 = cp5.addGroup("g2")
                .setPosition(300,100)
                .setWidth(300)
                .activateEvent(true)
                .setBackgroundColor(color(255,80))
                .setBackgroundHeight(100)
                .setLabel("Hello World.")
                ;
  
  cp5.addSlider("S-1")
     .setPosition(80,10)
     .setSize(180,9)
     .setGroup(g2)
     ;
     
  cp5.addSlider("S-2")
     .setPosition(80,20)
     .setSize(180,9)
     .setGroup(g2)
     ;
     
  cp5.addRadioButton("radio")
     .setPosition(10,10)
     .setSize(20,9)
     .addItem("black",0)
     .addItem("red",1)
     .addItem("green",2)
     .addItem("blue",3)
     .addItem("grey",4)
     .setGroup(g2)
     ;
}


void draw() {
  background(0);
}


void controlEvent(ControlEvent theEvent) {
  if(theEvent.isGroup()) {
    println("got an event from group "
            +theEvent.getGroup().getName()
            +", isOpen? "+theEvent.getGroup().isOpen()
            );
            
  } else if (theEvent.isController()){
    println("got something from a controller "
            +theEvent.getController().getName()
            );
  }
}


void keyPressed() {
  //WE can make it disappear and reappear WOOW
  if(key==' ') {
    if(cp5.getGroup("g1").isVisible()) {
      cp5.getGroup("g1").hide();
    }else{
      cp5.getGroup("g1").show();
    }
  }
}




/*
a list of all methods available for the Group Controller
use ControlP5.printPublicMethodsFor(Group.class);
to print the following list into the console.

You can find further details about class Group in the javadoc.

Format:
ClassName : returnType methodName(parameter type)


controlP5.ControlGroup : Group activateEvent(boolean) 
controlP5.ControlGroup : Group addListener(ControlListener) 
controlP5.ControlGroup : Group hideBar() 
controlP5.ControlGroup : Group removeListener(ControlListener) 
controlP5.ControlGroup : Group setBackgroundColor(int) 
controlP5.ControlGroup : Group setBackgroundHeight(int) 
controlP5.ControlGroup : Group setBarHeight(int) 
controlP5.ControlGroup : Group showBar() 
controlP5.ControlGroup : Group updateInternalEvents(PApplet) 
controlP5.ControlGroup : String getInfo() 
controlP5.ControlGroup : String toString() 
controlP5.ControlGroup : boolean isBarVisible() 
controlP5.ControlGroup : int getBackgroundHeight() 
controlP5.ControlGroup : int getBarHeight() 
controlP5.ControlGroup : int listenerSize() 
controlP5.ControllerGroup : CColor getColor() 
controlP5.ControllerGroup : ControlWindow getWindow() 
controlP5.ControllerGroup : ControlWindowCanvas addCanvas(ControlWindowCanvas) 
controlP5.ControllerGroup : Controller getController(String) 
controlP5.ControllerGroup : ControllerProperty getProperty(String) 
controlP5.ControllerGroup : ControllerProperty getProperty(String, String) 
controlP5.ControllerGroup : Group add(ControllerInterface) 
controlP5.ControllerGroup : Group bringToFront() 
controlP5.ControllerGroup : Group bringToFront(ControllerInterface) 
controlP5.ControllerGroup : Group close() 
controlP5.ControllerGroup : Group disableCollapse() 
controlP5.ControllerGroup : Group enableCollapse() 
controlP5.ControllerGroup : Group hide() 
controlP5.ControllerGroup : Group moveTo(ControlWindow) 
controlP5.ControllerGroup : Group moveTo(PApplet) 
controlP5.ControllerGroup : Group open() 
controlP5.ControllerGroup : Group registerProperty(String) 
controlP5.ControllerGroup : Group registerProperty(String, String) 
controlP5.ControllerGroup : Group remove(CDrawable) 
controlP5.ControllerGroup : Group remove(ControllerInterface) 
controlP5.ControllerGroup : Group removeCanvas(ControlWindowCanvas) 
controlP5.ControllerGroup : Group removeProperty(String) 
controlP5.ControllerGroup : Group removeProperty(String, String) 
controlP5.ControllerGroup : Group setAddress(String) 
controlP5.ControllerGroup : Group setArrayValue(float[]) 
controlP5.ControllerGroup : Group setColor(CColor) 
controlP5.ControllerGroup : Group setColorActive(int) 
controlP5.ControllerGroup : Group setColorBackground(int) 
controlP5.ControllerGroup : Group setColorForeground(int) 
controlP5.ControllerGroup : Group setColorLabel(int) 
controlP5.ControllerGroup : Group setColorValue(int) 
controlP5.ControllerGroup : Group setHeight(int) 
controlP5.ControllerGroup : Group setId(int) 
controlP5.ControllerGroup : Group setLabel(String) 
controlP5.ControllerGroup : Group setMouseOver(boolean) 
controlP5.ControllerGroup : Group setMoveable(boolean) 
controlP5.ControllerGroup : Group setOpen(boolean) 
controlP5.ControllerGroup : Group setPosition(PVector) 
controlP5.ControllerGroup : Group setPosition(float, float) 
controlP5.ControllerGroup : Group setStringValue(String) 
controlP5.ControllerGroup : Group setUpdate(boolean) 
controlP5.ControllerGroup : Group setValue(float) 
controlP5.ControllerGroup : Group setVisible(boolean) 
controlP5.ControllerGroup : Group setWidth(int) 
controlP5.ControllerGroup : Group show() 
controlP5.ControllerGroup : Group update() 
controlP5.ControllerGroup : Group updateAbsolutePosition() 
controlP5.ControllerGroup : Label getCaptionLabel() 
controlP5.ControllerGroup : Label getValueLabel() 
controlP5.ControllerGroup : PVector getPosition() 
controlP5.ControllerGroup : String getAddress() 
controlP5.ControllerGroup : String getInfo() 
controlP5.ControllerGroup : String getName() 
controlP5.ControllerGroup : String getStringValue() 
controlP5.ControllerGroup : String toString() 
controlP5.ControllerGroup : Tab getTab() 
controlP5.ControllerGroup : boolean isCollapse() 
controlP5.ControllerGroup : boolean isMouseOver() 
controlP5.ControllerGroup : boolean isMoveable() 
controlP5.ControllerGroup : boolean isOpen() 
controlP5.ControllerGroup : boolean isUpdate() 
controlP5.ControllerGroup : boolean isVisible() 
controlP5.ControllerGroup : boolean setMousePressed(boolean) 
controlP5.ControllerGroup : float getValue() 
controlP5.ControllerGroup : float[] getArrayValue() 
controlP5.ControllerGroup : int getHeight() 
controlP5.ControllerGroup : int getId() 
controlP5.ControllerGroup : int getWidth() 
controlP5.ControllerGroup : void remove() 
java.lang.Object : String toString() 
java.lang.Object : boolean equals(Object) 


*/
