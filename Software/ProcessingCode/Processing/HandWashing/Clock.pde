
// -----------------------------
// CLOCK
// -----------------------------

void displayClock() {
  pushMatrix(); pushStyle();
  
  /*** DATE ***/
  
  // Style
  textFont(small); 
  textAlign(RIGHT); 
  
  // Date
  theDate  = new SimpleDateFormat("EEEEEEEE").format(date);
  theYear  = new SimpleDateFormat("yyyy").format(date);
  theMonth = new SimpleDateFormat("MMMMMMMMM").format(date);
  theDay   = new SimpleDateFormat("dd").format(date);
  
  theDate = theDate.toUpperCase();
  theMonth = theMonth.toUpperCase();
  
  String date = theDate + ", " + theMonth + " " + theDay;
  
  // Drop Shadow
  fill(dropShadowColor, 200);  
  text(date, datePositionX + 2, datePositionY + 2);
  
  // Text
  fill(textColor, 200);  
  text(date, datePositionX, datePositionY);
  
  /*** TIME ***/
  
  // Style
  textFont(large); 
  textAlign(RIGHT); 
  
  // Time
  theHour = nf(hour(), 2);
  theMin  = nf(minute(), 2);
  theSec  =  nf( second(), 2);
  
  if(hour() >= 12) {
    theMeridiem = "PM";
  }
  else if(hour() < 12) {
    theMeridiem = "AM"; 
  }
  
  time = theHour + ":" + theMin + " " + theMeridiem;
  
  // Drop Shadow
  fill(dropShadowColor, 200);  
  text(time, timePositionX + 2, timePositionY + 2);   
  
  // Text
  fill(textColor, 200);  
  text(time, timePositionX, timePositionY);   


  /*** OTHER ***/

  // Reset Hour Count
  if( int(theMin) == 00 && int(theSec) == 00) {
    println(" -- Resetting Hourly Count --");
    for(int i = 0; i < sanitizers.length; i++) {  
      numHandsThisHour[i] = 0;
    }
    allHandsThisHour = 0;
    
    println(" -- Saving The Tables -- ");
    try {
      saveData(true, true, true); // not sure why we need to save data every hour
    }
    catch(Exception e) {
      e.printStackTrace();
      println("Couldn't Save The Tables :/ "); 
    }
  } 
  
  // Screenshot + Reset
  if ((int(theHour) == 00) && ((int(theMin) == 00  )) && ((int(theSec) == 30))) {
    takeSnapshot();
  }
    
  // Save + TimeStamp Data 
  // (this is being called twice right now ?!?)
  if ((int(theHour) == 01) && ((int(theMin) == 23  )) && ((int(theSec) == 30))) {
    // Save Picture    
    println("Time's up: theDay is " + theDay + " theDate is " + theDate);
    
    
    // Update Day + Month
    if(theDay == "01") {
      println("Updating Everything");
      saveStampedData(true, false, true, false);
      //resetData(true, false, true);
    }
    // Update The Day + Week
    else if(theDate.equals("MONDAY")) {
      println("Updating The Day and The Week");
      saveStampedData(true, true, false, false);
      //resetData(true, true, false);
      //Save W21CDataTable
      fileName = (Network_Name)+("_") + str(month()) + ("_") + str(day()) + ("_") + str((w21ctable.lastRowIndex())+1) + (".csv"); //this filename is of the form month+day+readingCounter
      saveTable(w21ctable, "W21C/Weekly/"+fileName); //Woo! save it to your computer. It is ready for all your spreadsheet dreams.
      
    }    
    // Update The Day + Week + Month
    else if(theDay == "01" && theDate.equals("MONDAY")) {
      println("Updating The Day and The Week");
      saveStampedData(true, true, false, true);
      //resetData(true, true, false);
    }
    // Just Update The Day    
    else {
      println("Just Updating The Day");
      saveStampedData(true, false, false, true);
      //resetData(true, false, false);
    }
    
    /* CALL RESET FROM SAVETIMESTAMP CUZ ITS ERASING BEFORE WE CAN SAVE IT */
    
  }
  
  // Reset Data 
  if ((int(theHour) == 01) && ((int(theMin) == 23  )) && ((int(theSec) == 40))) {
    // Save Picture    
    println("Time's up: theDay is " + theDay + " theDate is " + theDate);
    
    
    // Update Day + Month
    if(theDay == "01") {
      println("Resetting Everything");
      //saveStampedData(true, false, true, false);
      resetData(true, false, true);
    }
    // Update The Day + Week
    else if(theDate.equals("MONDAY")) {
      println("Resetting The Day and The Week");
      //saveStampedData(true, true, false, false);
      resetData(true, true, false);
    }    
    // Update The Day + Week + Month
    else if(theDay == "01" && theDate.equals("MONDAY")) {
      println("Resetting The Day and The Week");
      //saveStampedData(true, true, false, true);
      resetData(true, true, false);
    }
    // Just Update The Day    
    else {
      println("Just Resetting The Day");
      //saveStampedData(true, false, false, true);
      resetData(true, false, false);
    }
    
    /* CALL RESET FROM SAVETIMESTAMP CUZ ITS ERASING BEFORE WE CAN SAVE IT */
    
  }

  // Get New Calendar
  if ((int(theHour) == 00) && ((int(theMin) == 00  )) && ((int(theSec) == 00))) {
    getCalendar(); 
  }

  
  popMatrix(); popStyle();
}

// -----------------------------

String timeStamp() {
  String timestamp = year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second();
  return timestamp;
}

// -----------------------------

void getCalendar() {
  
   calendar = Calendar.getInstance();   
  date  = new java.util.Date(calendar.getTimeInMillis()); 
  
}
