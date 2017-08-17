
// -----------------------------
// MONTH VIEW
// -----------------------------

void drawMonthView(float _scale, float _translateX, float _translateY) {
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
  dailyLabel = "- LAST 30 DAYS -";

  // Style
  textFont(medium); 
  textAlign(CENTER); 

  // Drop Shadow
  fill(dropShadowColor);  
  text(dailyLabel, monthlyLabelPositionX + 2, monthlyLabelPositionY + 2);

  // Text
  fill(textColor);  
  text(dailyLabel, monthlyLabelPositionX, monthlyLabelPositionY);


  /* CHART */

  fill(chartColor, 200);
  stroke(chartColor); 
  strokeCap(SQUARE);

  // Baseline
  strokeWeight(10);
  fill(chartColor);
  ellipse(textPositionX, baseLineY, 30, 30);
  line(divStartX, baseLineY, divEndX, baseLineY); 

  // Line 1
  fill(chartColor, 200);
  strokeWeight(1);
  line(divStartX + 5, divOneY, divEndX, divOneY); 

  // Line 2
  strokeWeight(2);
  line(divStartX + 10, divTwoY, divEndX, divTwoY); 

  // Line 3
  strokeWeight(1);
  line(divStartX + 15, divThreeY, divEndX, divThreeY);  
  


  /* GRAPHICS */

  // Style
  stroke(255);
  fill(255);
  textFont(small);

  // NPE Workaround
  int ahtm;
  if (allHandsThisMonth == 0) {
    ahtm = 1;
  } else {
    ahtm = allHandsThisMonth;
  }

  // Text
  int count = 0;
  float spos = 0.0;
  float pypos = 0.0;
  float startY = 0.0;
  float pstartY = 0.0;
  float endY = 0.0;
  float heightY = 0.0;
  float yVal = 0.0;
  float yDiv = ((baseLineY - divThreeY) / ahtm);
  float xpos = 0.0;
  float dailyOffset = (divEndX - divStartX) / 31;
  float tweakedPosition = 18;

  // This Month  
  for (int i = day(); i > 0; i--) {    

    // Bar Position     
    xpos = divEndX - ((31 - i) * dailyOffset) - tweakedPosition;

    // Unit Bars
    for (int j = 0; j < numHandsThisMonth.length; j++ ) {
      // Value For Each Unit
      yVal = monthlyTable.getInt(j + 1, i);

      // Ending Position
      if (j == 0) {
        endY = baseLineY;
      } else {
        endY = startY;
      }      
      // Starting Position
      startY = endY - (yVal * yDiv);
      // Height
      heightY = endY - startY;

      // Colour
      noStroke();
      fill(sanitizers[j].myColor);
      
      // Shape
      stroke(0);
      rect(xpos, startY - 7, 15, heightY);    
      
    }
    //println("XPOS for " + i + " is " + xpos);
    //println("");

    // Text Position
    float txpos = divEndX - (i-2) * ((divEndX - divStartX) / 31) - (divStartX + (divEndX - divStartX) / 31) - ((divEndX - divStartX) / 31);
    
    // Text
    fill(chartColor);
    text(i, divEndX - txpos, baseLineY + 75);
    
    // Store Last Position
    if (i == 1) {
      spos = txpos;
    }
    
    // Iterate
    count++;
  }

  // Last Month  
  int rem = 31 - count;
  //println("Count is " + count);
  //println("Remainder is " + rem);

  for (int i = 31; i > 31 - rem; i--) {  

    // Bar Position     
    xpos = divEndX - ((31 - i) * dailyOffset) - tweakedPosition;

    // Unit Bars
    for (int j = 0; j < numHandsThisMonth.length; j++ ) {
      // Value For Each Unit
      yVal = monthlyTable.getInt(j + 1, i);

      // Ending Position
      if (j == 0) {
        endY = baseLineY;
      } else {
        endY = startY;
      }      
      // Starting Position
      startY = endY - (yVal * yDiv);
      // Height
      heightY = endY - startY;

      // Colour
      noStroke();
      fill(sanitizers[j].myColor);
      
      // Shape
      stroke(0);
      rect(xpos, startY - 7, 15, heightY);    
      
    }
    //println("XPOS for " + i + " is " + xpos);
    //println("");

    // Text Position
    float txpos = divStartX - (i-2) * ( (divEndX - divStartX) / 31) - (divStartX + (divEndX - divStartX) / 31) - ((divEndX - divStartX) / 31) ;
    
    // Text
    fill(chartColor);
    text(i, divStartX - txpos, baseLineY + 75);
  }



  popMatrix(); 
  popStyle();
} /* End Of Month View */


