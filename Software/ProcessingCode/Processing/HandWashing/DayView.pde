
// -----------------------------
// DAY VIEW
// -----------------------------

void drawDayView(float _scale, float _translateX, float _translateY) {
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
  dailyLabel = "- TODAY -";

  // Style
  textFont(medium); 
  textAlign(CENTER); 

  // Drop Shadow
  fill(dropShadowColor);  
  text(dailyLabel, dailyLabelPositionX + 2, dailyLabelPositionY + 2);

  // Text
  fill(textColor);  
  text(dailyLabel, dailyLabelPositionX, dailyLabelPositionY);

  /* CHART */

  fill(chartColor);
  stroke(chartColor); 
  strokeCap(SQUARE);

  // Baseline
  strokeWeight(10);
  ellipse(textPositionX, baseLineY, 30, 30);
  line(divStartX, baseLineY, divEndX, baseLineY); 

  // Line 1
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
  strokeWeight(10);
  strokeJoin(MITER);
  strokeCap(ROUND);

  // NPE Workaround
  int ahtd;
  if (allHandsThisDay <= 3) {
    ahtd = 3;
  } else {
    ahtd = allHandsThisDay;
  }
  for (int i = 1; i < dailyTable.getColumnCount()-1; i++ ) { 

    // Vars
    float xpos = divStartX + i * ((divEndX - divStartX) / 24);
    float nxpos = divStartX + (i+1) * ((divEndX - divStartX) / 24);
    int y = dailyTable.getInt(totalRow, i);
    int ny = dailyTable.getInt(totalRow, i+1);
    float ypos = baseLineY - y * ((baseLineY - divThreeY) / (ahtd/3));
    float nypos = baseLineY - ny * ((baseLineY - divThreeY) / (ahtd/3));

    // Line
    if (i < dailyTable.getColumnCount()-2) {
      line(xpos, ypos, nxpos, nypos);
    } else {
      line(xpos, ypos, xpos, ypos);
    }
    // Text
    if (i % 3 == 0) {
      if (i <= 12) {
        text(i, xpos, baseLineY + 50);
      } else if (i > 12) {
        text(i - 12, xpos, baseLineY + 50);
      }
    }
  }

  popMatrix(); 
  popStyle();
} /* End Of Day View */


