
// -----------------------------
// WEEK VIEW
// -----------------------------

void drawWeekView(float _scale, float _translateX, float _translateY) {
  pushMatrix(); 
  pushStyle();

  /* SCALE */
  translate(_translateX, _translateY);
  scale(_scale);

  // Box
  pushStyle();
    fill(0, 128);
    noStroke();
    rect(textPositionX - 50, textPositionY - 100, width - (textPositionX * 2) + 100, height - (textPositionY * 2)+ 150);
  popStyle();

  /* LABEL */

  // Label
  dailyLabel = "- LAST 7 DAYS -";

  // Style
  textFont(medium); 
  textAlign(CENTER); 

  // Drop Shadow
  fill(dropShadowColor);  
  text(dailyLabel, weeklyLabelPositionX + 2, weeklyLabelPositionY + 2);

  // Text
  fill(textColor);  
  text(dailyLabel, weeklyLabelPositionX, weeklyLabelPositionY);




  /* GRAPHICS */

  // Style
  stroke(0);
  noFill();
  textFont(small);
  strokeWeight(2);
  strokeJoin(MITER);
  strokeCap(ROUND);
  //noStroke();

  // NPE Workaround
  int ahtw;
  if (allHandsThisWeek == 0) {
    ahtw = 1;
  } else {
    ahtw = allHandsThisWeek;
  }
  
  // Vars
  float[] diameterPerDay = new float[7];
  int[]   anglesPerDay = new int[7]; 
  float[] numPerDay = new float[7];
  float[] percentagePerDay = new float[7];
  float   lastAngle = 0;
  int     highestNumber = 0;
  float   highestDay = 0;
  int     dayToDraw = -1;
  float   textAngle = 0;
  
  // Get The Total Values Per Day
  for (int i = 1; i < weeklyTable.getColumnCount()-1; i++ ) {
    numPerDay[i-1] = weeklyTable.getInt(totalRow, i);               // Total Number Of Presses Per Unit Per Day
    
    // Get The Day With The Highest Number
    if(numPerDay[i-1] > highestDay) {
      highestNumber = i-1;
      highestDay    = numPerDay[i-1];
    }

    percentagePerDay[i-1] = numPerDay[i-1] / ahtw;                  // Percentage Of Each Unit To The Total
    anglesPerDay[i-1] = int(percentagePerDay[i-1] * 360);           // Final Angle For The Pie Chart
    diameterPerDay[i-1] = map(numPerDay[i-1], 0, ahtw, 0, height);  // Height Per Slice per Day
  }
  
  // Get The Date As An Int
  dayToDraw = getDateAsInt();
  
  // Rotate To The Current Day
  //lastAngle += radians(anglesPerDay[dayToDraw]);
  lastAngle += radians(anglesPerDay[highestNumber]);
  
  // Draw The Pie Chart
  for (int i = 0; i < anglesPerDay.length; i++) {
    // Color
    if(i < 6) fill(palette[i]);
    else fill(255);  
    
    // Draw The Arc
    arc(width/2, height/2, diameterPerDay[i], diameterPerDay[i], lastAngle, lastAngle + radians(anglesPerDay[i]), PIE);
    
    // Update New Starting Angle
    lastAngle += radians(anglesPerDay[i]);
  }
  
  // Draw Text
  String biggestDay = getDateAsString(highestNumber);
  fill(255,225);
  text(biggestDay, width / 2, diameterPerDay[highestNumber] - 100);
  
  popMatrix(); 
  popStyle();
} /* End Of Week View */


// -----------------------------


// Get Date
int getDateAsInt() {
  
  int dayToDraw = -1;
  
  if(theDate.equals("MONDAY")) {
    dayToDraw = 0;
  }
  else if(theDate.equals("TUESDAY")) {
    dayToDraw = 1;
  }
  else if(theDate.equals("WEDNESDAY")) {
    dayToDraw = 2;
  }
  else if(theDate.equals("THURSDAY")) {
    dayToDraw = 3;
  }
  else if(theDate.equals("FRIDAY")) {
    dayToDraw = 4;
  }
  else if(theDate.equals("SATURDAY")) {
    dayToDraw = 5;
  }
  else if(theDate.equals("SUNDAY")) {
    dayToDraw = 6;
  }
  
  return dayToDraw;
}

// -----------------------------

String getDateAsString(int d) {
  
  String highestDay = "";
  
  if(d == 0) {
    highestDay = "MONDAY";
  }
  else if(d == 1) {
    highestDay = "TUESDAY";
  }
  else if(d == 2) {
    highestDay = "WEDNESDAY";
  }
  else if(d == 3) {
    highestDay = "THURSDAY";
  }
  else if(d == 4) {
    highestDay = "FRIDAY";
  }
  else if(d == 5) {
    highestDay = "SATURDAY";
  }
  else if(d == 6) {
    highestDay = "SUNDAY";
  }
  
  return highestDay;
}



