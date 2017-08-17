
// -----------------------------
// DRAW
// -----------------------------

void draw() {    
  
  // Background
  background(bgColor);
  //diagonalGrid();
  
  // Serial
  readSerial();
  
  // Timer
  checkTime();
  
  // Trigger Mode
  if(drawState == 1) { 
    
    // Draw All The Hands
    drawHands();

    // Draw Date & Time
    displayCount();
    displayClock();
  }
  // Semi Sleep Mode
  else if(drawState == 2) {
    
    // Draw All The Hands
    drawHands();
    
    // Draw States 
    
    // Day View 
    if(subDrawState == 1) {
      drawDayView(0.25, width * 0.375, height * 0.75);
    }
    // VCH Logo
    else if(subDrawState == 2) {
      displayVCH(0.25, width * 0.3, height * 0.75);  
    }
    // Week View
    else if(subDrawState == 3) {
      drawWeekView(0.25, width * 0.375, height * 0.75);
    }
    // ECUAD Logo
    else if(subDrawState == 4) {
      displayECUAD(0.25, width * 0.3, height * 0.75);   
    }
    // Month View
    else if(subDrawState == 5) {
      drawMonthView(0.25, width * 0.375, height * 0.75);
    }
    
    // Draw Date & Time
    displayCount();
    displayClock();
    
  }
  // Full Sleep Mode
  else if(drawState == 3) {
    
    // Draw States 
    
    // Day View 
    if(subDrawState == 1) {
      drawDayView(1.0, 0.0, 0.0);
    }
    // VCH Logo
    else if(subDrawState == 2) {
      displayVCH(0.5, width * 0.1, height/4);  
    }
    // Week View
    else if(subDrawState == 3) {
      drawWeekView(1.0, 0.0, 0.0);
    }
    // ECUAD Logo
    else if(subDrawState == 4) {
      displayECUAD(0.5, width * 0.1, height/4);   
    }
    // Month View
    else if(subDrawState == 5) {
      drawMonthView(1.0, 0.0, 0.0);
    }
    
    // Draw Date & Time
    displayCount();
    displayClock();
    
  }
  
  if(frameCount % 6000 == 0) {
    int fps = round(frameRate);
    println(" -- VCH Hand Sanitizer Running at " + fps + " FPS -- "); 
    println(" -- The Time Is " + time + " And Our Free Memory Is " + Runtime.getRuntime().freeMemory()/1024 + " K -- ");
    System.gc();
    println(" -- We Garbage Collected And Our Free Memory Is Now " + Runtime.getRuntime().freeMemory()/1024 + " K -- ");
    println("\n");
  }

  
} /* End Of Draw() */

