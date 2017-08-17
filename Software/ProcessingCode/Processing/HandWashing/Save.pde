
// -----------------------------
// SAVING + RESETTING DATA
// -----------------------------

void takeSnapshot() {
  println(" -- SAVING A SCREENSHOT- ");
  
  // Snap A Picture
  save("Screenshots/handproject_" + timeStamp()+ ".PNG");
  
}

// -----------------------------

void saveData(boolean day, boolean week, boolean month) {
  println(" -- SAVING THE DATA -- ");
  
  //Save W21CDataTable
  fileName = (Network_Name)+("_") + str(month()) + ("_") + str(day()) + ("_") + str((w21ctable.lastRowIndex())+1) + (".csv"); //this filename is of the form month+day+readingCounter
  saveTable(w21ctable, "W21C/Manual Save/"+fileName); //Woo! save it to your computer. It is ready for all your spreadsheet dreams.
  
  // Save Tables
  if(day) {
    try {
      saveTable(dailyTable, "Saved/dailyTable.tsv");
    }
    catch(Exception e) {
      e.printStackTrace();
      println("Couldn't Save The Daily Table :/ "); 
    }
  }
  
  if(week) {
    try {
      saveTable(weeklyTable, "Saved/weeklyTable.tsv");
    }
    catch(Exception e) {
      e.printStackTrace();
      println("Couldn't Save The Weekly Table :/ "); 
    }
  }
  
  if(month) {
    try {
      saveTable(monthlyTable, "Saved/monthlyTable.tsv");
    }
    catch(Exception e) {
      e.printStackTrace();
      println("Couldn't Save The Monthly Table :/ "); 
    }
  } 

}

// SAVE TIMESTAMPED TABLES AT END OF CYCLE
void saveStampedData(boolean day, boolean week, boolean month, boolean overwrite) {
  println(" -- SAVING THE TIME STAMPED DATA -- ");
  
  // Save Tables
  if(day) {
    try {
      saveTable(dailyTable, "Saved/_Stamped/dailyTable_" + timeStamp()+ ".tsv");
    }
    catch(Exception e) {
      e.printStackTrace();
      println("Couldn't Save The Daily Table :/ "); 
    }
    
    // Reset Day
    if(overwrite) {
      println("Overwriting Day");
      resetData(true, false, false);
    }
  }
  

  
  if(week) {
    try {
      saveTable(weeklyTable, "Saved/_Stamped/weeklyTable_" + timeStamp()+ ".tsv");
    }
    catch(Exception e) {
      e.printStackTrace();
      println("Couldn't Save The Weekly Table :/ "); 
    }
    
    // Reset Week
    if(overwrite) {
            println("Overwriting Week");
      resetData(false, true, false);
    }
  }
  
  
  if(month) {
    try {
      saveTable(monthlyTable, "Saved/_Stamped/monthlyTable_" + timeStamp()+ ".tsv");
    }
    catch(Exception e) {
      e.printStackTrace();
      println("Couldn't Save The Monthly Table :/ "); 
    }

    // Reset Day & Month    
    if(overwrite) {
            println("Overwriting Month");
      resetData(false, false, true);
    }
  } 
  

}


// -----------------------------
// RESET
// -----------------------------

void resetData(boolean day, boolean week, boolean month) {
  
  // Update Day
  if(day) {
    println("Resetting Day");
    updateDay(true, true);
  }
  
  // Update Week
  if(week) {
    println("Resetting Week");
    updateWeek(true, true);
  } 
  
  // Update Month
  if(month) {
    println("Resetting Month");
    updateMonth(true, true);
  }

  // Reset Stored Variables
  allHandsThisDay = 0;
  allHandsThisHour  = 0;
  allHandsThisDay   = 0;
  allHandsThisWeek  = 0;
  allHandsThisMonth = 0;
  allHandsThisYear  = 0;
  
  colorNumber = 0;
  count = 0;
  
  //
  resetTimer();
  
    // Remove Items From ArrayList
  for (int i = hands.size()-1; i >= 0; i--) { 
    hands.remove(i);
  } 
  
}

