
// -----------------------------
// GRAPHICS
// -----------------------------


void displayCount() {
  pushMatrix(); pushStyle();
  
  int currentCount = allHandsThisDay * 2;

  textFont(large);
  textAlign(LEFT); 

  // Drop Shadow
  fill(dropShadowColor);
  text(currentCount + " CLEAN HANDS TODAY", textPositionX + 2, textPositionY + 2); 
  
  // Text
  fill(textColor);
  text(currentCount + " CLEAN HANDS TODAY", textPositionX, textPositionY);
  
  popMatrix(); popStyle();
}

// -----------------------------

void displayGrid() {
  pushMatrix(); pushStyle();
  
  for (int i = 1; i < 24; i++) {
    stroke(255, 20);
    line((width/24)*i, 0, (width/24)*i, height);
  }
  
  popMatrix(); popStyle();
}

// -----------------------------

void diagonalGrid() {
  for (int i = 1; i < 220; i++) {
    stroke(51);
    line((i*15), 0, 0, (i*15));
    noStroke();
  }
}

// -----------------------------
