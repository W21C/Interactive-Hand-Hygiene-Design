
// -----------------------------
// SANITIZER CLASS
// -----------------------------

class Sanitizer {

  // VARIABLES
  // -----------------------------

  TheHand hand;
  
  int deviceID;
  String deviceName;
  float pwmRate;
  
  color myColor;
  
  int triggersThisHour;
  int triggersThisDay;
  int triggersThisWeek;
  int triggersThisMonth;
  int triggersThisYear;
  
  int currHour;
  int lastHour;
  int currMinute;
  int lastMinute;
  int currSecond;
  int lastSecond;  
  
  int timeoutPeriod = 2000;
  int triggerTime = 0;
  boolean readyToTrigger = true;

  
 
  // CONSTRUCTOR
  // -----------------------------

  Sanitizer(int _id, color _color) {

    deviceID = _id;
    deviceName = "UNIT " + str(deviceID + 1);
    myColor = _color;
    
  }
  
  
  
  // TRIGGER
  // -----------------------------

  void dispenserTriggered(int _id) {
    println(" -- TRIGGERING UNIT #" + _id + " -- ");
    
    // Reset Screen
    drawState = 1;
    subDrawState = 1;
    
    // Set XY
    int prevX = newX;
    int prevY = newY;
  
    float upperXlimit = width * 0.95;
    float lowerXlimit = width * 0.05;
    float upperYlimit = height * 0.85;
    float lowerYlimit = height * 0.15;
    newX = round(random(lowerXlimit, upperXlimit));
    newY = round(random(lowerYlimit, upperYlimit));
    
    // Add New Hand
    hands.add(new TheHand(myColor, newX, newY, prevX, prevY));
   
    // Update Dataset   
    updateData(true);
    
    // Reset Timer
    resetTimer();
      
    // Animate
    anim.start();
  
    // Play Sound
    samples[deviceID].trigger();
    
    // Reset Boolean & Run Timeout Method
    readyToTrigger = false;
    triggerTime = millis();
  
  }
  
   // TIMEOUT
  // -----------------------------

  boolean runTimeout() {
    int deviceID_Fix = deviceID +1;
    println(" -- RUNNING TIMEOUT FOR UNIT #" + deviceID_Fix + " -- ");
    
    if((millis() - triggerTime) >= timeoutPeriod ) {
       readyToTrigger = true; 
    }
    
    return readyToTrigger;
  }
  
  // SAVE
  // -----------------------------

  void updateData(boolean overwrite) {
    println(" -- UPDATING DATA -- ");
    
    try {
    
      // Update Counters
      allHandsThisHour++;
      allHandsThisDay++;
      allHandsThisWeek++;
      allHandsThisMonth++;
      count++; 
      
      numHandsThisHour[deviceID]++;
      numHandsThisDay[deviceID]++;
      numHandsThisWeek[deviceID]++;
            println("NHPDTW " + numHandsPerDayThisWeek[6]);
      //numHandsPerDayThisWeek[deviceID]++; // Below
      numHandsThisMonth[deviceID]++;
      numHandsPerDayThisMonth[day()-1]++; // NPE
      
      println(deviceName + " has been triggered " + numHandsThisHour[deviceID] + " times this hour...");
      println("Device #" + deviceID + " has been triggered " + numHandsThisDay[deviceID] + " times today...");
      
      /* Daily Table */
      
      // Update Individual 
      dailyTable.setInt(deviceID + 1, hour() + 1, numHandsThisHour[deviceID]);
      // Update Total Per Hour
      dailyTable.setInt(totalRow, hour() + 1, allHandsThisHour);
      // Update Total Per Day
      dailyTable.setInt(deviceID + 1, dailyTable.getColumnCount()-1, numHandsThisDay[deviceID]);
      // Update Daily Total
      dailyTable.setInt(totalRow, dailyTable.getColumnCount()-1, allHandsThisDay);
      
      /* Weekly Table */
      
      String dayOfWeek  = new SimpleDateFormat("EEE").format(date);
      dayOfWeek = dayOfWeek.toUpperCase();
      //println("The Day Is " + dayOfWeek);
      int currDay = 0;
      
      for(int i = 0; i < weeklyTable.getColumnCount(); i++) {
        if( weeklyTable.getString(0, i).equals(dayOfWeek) ) {
          currDay = i-1;
          //println(" -------- SUCCESS ------- ");
          println("Current Day is " + currDay);
        }
      }
      
      println("NHPDTW " + numHandsPerDayThisWeek[currDay]);
      numHandsPerDayThisWeek[currDay]++; // NPE
      println("NHPDTW " + numHandsPerDayThisWeek[currDay]);

      
      // Update Individiual Total Per Day
      weeklyTable.setInt(deviceID + 1, currDay + 1, numHandsThisDay[deviceID]);
      // Update Cumulative Total Per Day
      weeklyTable.setInt(totalRow, currDay + 1, numHandsPerDayThisWeek[currDay]); // NPE
      println("TPR " + totalRow + "\t" + currDay +  "\t" + numHandsPerDayThisWeek[currDay]);
      // Update Total Per Day
      weeklyTable.setInt( deviceID + 1, weeklyTable.getColumnCount()-1, numHandsThisWeek[deviceID]);
      println("TPD " + deviceID + 1 + "\t" + str(weeklyTable.getColumnCount()-1) +  "\t" + numHandsThisWeek[deviceID]);

      // Update Cumulative Weekly Total
      weeklyTable.setInt(totalRow, weeklyTable.getColumnCount()-1, allHandsThisWeek);
      
      /* Monthly Table */
      
      // Update Individiual Total Per Day
      monthlyTable.setInt(deviceID + 1, day(), numHandsThisDay[deviceID]); // Don't Add +1 as day() returns 1-31
      // Update Cumulative Total Per Day
      monthlyTable.setInt(totalRow, day(), numHandsPerDayThisMonth[day()-1]); // NPE
      // Update Total Per Day
      monthlyTable.setInt( deviceID + 1, monthlyTable.getColumnCount()-1, numHandsThisMonth[deviceID]);
      // Update Cumulative Monthly Total
      monthlyTable.setInt(totalRow, monthlyTable.getColumnCount()-1, allHandsThisMonth);
      
      println(allHandsThisDay + " " + allHandsThisWeek + " " + allHandsThisMonth);
    
    }
    catch(Exception e) {
      println("WHOA!!");
      e.printStackTrace(); 
    }
    
  }

  

} /* End Of Class Sanitizer */


