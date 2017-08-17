
// -----------------------------
// HAND CLASS
// -----------------------------

class TheHand { 
  
  PShape img;
  color c1;
  color c2 = color(255, 120);

  int deviceID;
  
  int xPos;
  int yPos;
  int xPos2;
  int yPos2;
  int prevX;
  int prevY;
  float xspeed;
  float rotation;
  int scale1 = 2000;
  int scale2 = int(random(150, 500));
  //int scale1 = 150;
  //int scale2 = int(random(50, 150));

  // Constructor
  TheHand(color tempC, int Xpos, int Ypos, int oldXpos, int oldYpos) { 
    c1 = tempC;
    xPos = Xpos;
    yPos = Ypos;
    prevX = oldXpos;
    prevY = oldYpos;
    rotation = random(3);
    img = loadShape("Shapes/hand.svg");
  }

  void display() {
    pushMatrix(); pushStyle();
    
    img.disableStyle();
    translate(prevX, prevY);
    rotate(rotation);
    fill(c1);
    noStroke();
    shapeMode(CENTER);
    shape(img, 0, 0, scale2, scale2);

    popMatrix(); popStyle();
  }

  void animate() {
    pushMatrix(); 
    pushStyle();
    
    img.disableStyle();
    float scaler = lerp(scale1, scale2, anim.position() );
    color c = lerpColor( c2, c1, anim.position() );
    xPos = round(lerp( displayWidth/2,  prevX, anim.position() ));
    yPos = round(lerp( displayHeight/2, prevY, anim.position() ));

    translate(xPos, yPos);
    rotate(rotation);
    fill(c);
    noStroke();
    shapeMode(CENTER);
    shape(img, 0, 0, scaler, scaler);
    
    popMatrix(); 
    popStyle();
  }
    
} /* End of Class Hand */

// -----------------------------
// HAND FUNCTION
// -----------------------------

void drawHands() {
  pushMatrix(); pushStyle();
  
  for (int i = 0; i <= hands.size(); i++) {
    if ((i+1) == hands.size()) {
      tempHand = (TheHand)hands.get(i);
      tempHand.animate();
    }
    if (i < (hands.size()-1)){
      tempHand = (TheHand)hands.get(i);
      tempHand.display();
    } 
  } 
  
  popMatrix(); popStyle();
}
