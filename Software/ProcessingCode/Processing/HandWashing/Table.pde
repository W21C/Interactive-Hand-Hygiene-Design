
// -----------------------------
// TABLE
// -----------------------------

/* 

Various Methods For Reading/Writing/Reorganizing Table Data

*/

void updateDay(boolean resetArray, boolean resetTable) {
  println(" -- UPDATING DAILY TABLE -- ");
  
  if(resetArray) {
    for(int i = 0; i < numHandsThisHour.length; i++) {
      println("Old Daily Count Is " + numHandsThisHour[i]);
      numHandsThisHour[i] = 0;
      println("New Daily Count Is " + numHandsThisHour[i]);
    }
    
    for(int i = 0; i < numHandsThisDay.length; i++) {
      println("Old Daily Count Is " + numHandsThisDay[i]);
      numHandsThisDay[i] = 0;
      println("New Daily Count Is " + numHandsThisDay[i]);
    }
  }
  
  if(resetTable) {
    for(int i = 0; i < dailyTable.getColumnCount(); i++ ) {
      // Update Individual 
      for(int j = 0; j < dailyTable.getRowCount(); j++) {
        if(i > 0 && j > 0) {
          dailyTable.setInt(j, i, 0);
        }
      }
      // Update Total Row    
      if(i > 0) {
        dailyTable.setInt(totalRow, i, 0); 
      }
    }
    // Save Table
    saveData(true, false, false);
  }
  
}

// -----------------------------

void updateWeek(boolean resetArray, boolean resetTable) {
  println(" -- UPDATING WEEKLY TABLE -- ");
  
  if(resetArray) {
    for(int i = 0; i < numHandsThisWeek.length; i++) {
      println("Old Weekly Count Is " + numHandsThisWeek[i]);
      numHandsThisWeek[i] = 0;
      println("New Weekly Count Is " + numHandsThisWeek[i]);
    }
    for(int i = 0; i < numHandsPerDayThisWeek.length; i++) {
      println("Old DayPerWeek Count Is " + numHandsPerDayThisWeek[i]);
      numHandsPerDayThisWeek[i] = 0;
      println("New DayPerWeek Count Is " + numHandsPerDayThisWeek[i]);
    }
  }
  
  if(resetTable) {
    for(int i = 0; i < weeklyTable.getColumnCount(); i++ ) {
      // Update Individual 
      for(int j = 0; j < weeklyTable.getRowCount(); j++) {
        println(i + "\t" + j);
        if(i > 0 && j > 0) {
          weeklyTable.setInt(j, i, 0);
        }
      }
      // Update Total Row    
      if(i > 0) {
        weeklyTable.setInt(totalRow, i, 0); 
      }
    }
    // Save Table
    saveData(false, true, false);
  }
  
}

// -----------------------------

void updateMonth(boolean resetArray, boolean resetTable) {
  println(" -- UPDATING MONTHLY TABLE -- ");
  
  
  if(resetArray) {
    for(int i = 0; i < numHandsThisMonth.length; i++) {
      println("Old Weekly Count Is " + numHandsThisMonth[i]);
      numHandsThisMonth[i] = 0;
      println("New Weekly Count Is " + numHandsThisMonth[i]);
    }
    for(int i = 0; i < numHandsPerDayThisMonth.length; i++) {
      println("Old DayPerWeek Count Is " + numHandsPerDayThisMonth[i]);
      numHandsPerDayThisMonth[i] = 0;
      println("New DayPerWeek Count Is " + numHandsPerDayThisMonth[i]);
    }
  }
  
  if(resetTable) {
    for(int i = 0; i < monthlyTable.getColumnCount(); i++ ) {
      // Update Individual 
      for(int j = 0; j < monthlyTable.getRowCount(); j++) {
        if(i > 0 && j > 0) {
          monthlyTable.setInt(j, i, 0);
        }
      }
      // Update Total Row    
      if(i > 0) {
        monthlyTable.setInt(totalRow, i, 0); 
      }
    }
    // Save Table
    saveData(false, false, true);
  }
  
}

// -----------------------------

void readDay() {

  // Daily Table
  println("In the Daily Table, there are " + dailyTable.getRowCount() + " Rows and " + dailyTable.getColumnCount() + " Columns");
  
  // All Cumulative Hands For The Current Day
  allHandsThisDay = dailyTable.getInt(totalRow, dailyTable.getColumnCount()-1);
  println("There are already " + allHandsThisDay + " presses this DAY");    
  
  // Number Of Hands For The Current Day Per Unit
  for(int i = 0; i < numHandsThisDay.length; i++) {
    numHandsThisDay[i] = dailyTable.getInt(i + 1, dailyTable.getColumnCount()-1);
    println("There are already " + numHandsThisDay[i] + " presses today for Unit #" + i);
  }
  
  // All Hands For The Current Hour Per Unit
  for(int i = 0; i < dailyTable.getColumnCount()-1; i++ ) {
    if(dailyTable.getInt(0, i) == hour() ) {
      for(int j = 0; j < sanitizers.length; j++) {  
        numHandsThisHour[j] = dailyTable.getInt(j + 1, i);
      }
      allHandsThisHour = dailyTable.getInt(totalRow, i);
      println("There are already " + allHandsThisHour + " presses this HOUR");
    }
  }
  
  println("");
}

// -----------------------------

void readWeek() {
  
  // Weekly Table
  println("In the Weekly Table, there are " + weeklyTable.getRowCount() + " Rows and " + weeklyTable.getColumnCount() + " Columns");
  
  // All Hands For The Current Day Of The Week Per Unit
  for(int i = 0; i < weeklyTable.getColumnCount()-2; i++ ) { // Need to make this get to 7
    numHandsPerDayThisWeek[i] = weeklyTable.getInt(totalRow, i);
    println("There are already " + numHandsPerDayThisWeek[i] + " presses for DAY #" + i + " of the WEEK");
  }
  
  println("");
  
  // All Hands This Week Per Unit
  for(int i = 0; i < numHandsThisWeek.length; i++ ) {
    numHandsThisWeek[i] = weeklyTable.getInt(i + 1, weeklyTable.getColumnCount()-1);
    println("There are already " + numHandsThisWeek[i] + " presses for Unit#" + i + " this WEEK");
  }
  
  // All Cumulative Hands This Week
  allHandsThisWeek = weeklyTable.getInt(totalRow, weeklyTable.getColumnCount()-1);    
  println("There are already " + allHandsThisWeek + " presses this WEEK");
  
  println("");
}

// -----------------------------

void readMonth() {
  
  // Monthly Table
  println("In the Monthly Table, there are " + monthlyTable.getRowCount() + " Rows and " + monthlyTable.getColumnCount() + " Columns");
  
  // All Hands For The Current Day Of The Month Per Unit
  for(int i = 1; i < monthlyTable.getColumnCount()-2; i++ ) {
    numHandsPerDayThisMonth[i] = monthlyTable.getInt(totalRow, i);
    println("There are already " + numHandsPerDayThisMonth[i] + " presses for DAY #" + i + " of the MONTH");
  }
  
  println("");
  
  // All Hands This Month Per Unit
  for(int i = 0; i < numHandsThisMonth.length; i++ ) {
    numHandsThisMonth[i] = monthlyTable.getInt(i + 1, monthlyTable.getColumnCount()-1);
    println("There are already " + numHandsThisMonth[i] + " presses for Unit#" + i + " this MONTH");
  }
  
  // All Cumulative Hands This Week
  allHandsThisMonth = monthlyTable.getInt(totalRow, monthlyTable.getColumnCount()-1);    
  println("There are already " + allHandsThisMonth + " presses this MONTH");
  
  println("");
}

// -----------------------------


