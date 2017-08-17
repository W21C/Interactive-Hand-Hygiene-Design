
// -----------------------------
// KEY
// -----------------------------

void keyPressed() {
  // Save
  if (key == 'p' || key == 'P') {
    takeSnapshot();
  } 
  if (key == 's' || key == 'S') {
    saveData(true, true, true);
    //saveStampedData(true, true, true, false);
  } 
  
  // Reset
  else if (key == 'r' || key == 'R') { // All
    resetData(true, true, true);
  }
  else if (key == 'd' || key == 'D') { // Just Daily
    resetData(true, false, false);
  }
  else if (key == 'w' || key == 'W') { // Just Weekly
    resetData(false, true, false);
  }
  else if (key == 'm' || key == 'M') { // Just Monthly
    resetData(false, false, true);
  }

  // Trigger
  else if (keyCode == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' ) {
    // Get The Key #
    int id = int(KeyEvent.getKeyText(keyCode));
    // Check If The Timer Has Elapsed
    if( sanitizers[id-1].runTimeout() ) {
      sanitizers[id-1].dispenserTriggered(id-1);
    }
    else {
      println("Sorry, But Sanitizer #" + str(id-1) + " Isn't Ready To Be Triggered Again Quite Yet...");
    }
  } 
  
  // Modes
  else if (key == 'z' || key == 'Z') { // Main State
    drawState++;
    if(drawState >= 4) drawState = 1;
  }
  else if (key == 'y' || key == 'Y') { // Sub State
    subDrawState++;
    if(subDrawState >= 6) subDrawState = 1;
  }
}



