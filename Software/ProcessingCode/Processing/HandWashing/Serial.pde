
// -----------------------------
// SERIAL COMMUNICATION
// -----------------------------

void readSerial() {

  // Is This Thing On ?
  if(useSerial == true && myPort.available() >= 1) {  
        
        SerialIn = myPort.readStringUntil('\n');
        SerialIn = (SerialIn == null) ? null : SerialIn.trim();
        println(SerialIn);
        if("A".equals(SerialIn)){ value1 = 1; pumpName=Network_Name+"_Tx1"; batteryFlag=1;}
        else if("B".equals(SerialIn)){ value1 = 1; pumpName=Network_Name+"_Tx1"; batteryFlag=0;}
        else if("C".equals(SerialIn)){ value1 = 2; pumpName=Network_Name+"_Tx2"; batteryFlag=1;}
        else if("D".equals(SerialIn)){ value1 = 2; pumpName=Network_Name+"_Tx2"; batteryFlag=0;}
        else if("E".equals(SerialIn)){ value1 = 3; pumpName=Network_Name+"_Tx3"; batteryFlag=1;}
        else if("F".equals(SerialIn)){ value1 = 3; pumpName=Network_Name+"_Tx3"; batteryFlag=0;}
        else if("G".equals(SerialIn)){ value1 = 4; pumpName=Network_Name+"_Tx4"; batteryFlag=1;}
        else if("H".equals(SerialIn)){ value1 = 4; pumpName=Network_Name+"_Tx4"; batteryFlag=0;}
        else if("I".equals(SerialIn)){ value1 = 5; pumpName=Network_Name+"_Tx5"; batteryFlag=1;}
        else if("J".equals(SerialIn)){ value1 = 5; pumpName=Network_Name+"_Tx5"; batteryFlag=0;}
        else if("K".equals(SerialIn)){ value1 = 6; pumpName=Network_Name+"_Tx6"; batteryFlag=1;}
        else if("L".equals(SerialIn)){ value1 = 6; pumpName=Network_Name+"_Tx6"; batteryFlag=0;}
        else if("M".equals(SerialIn)){ value1 = 7; pumpName=Network_Name+"_Tx7"; batteryFlag=1;}
        else if("N".equals(SerialIn)){ value1 = 7; pumpName=Network_Name+"_Tx7"; batteryFlag=0;}
        
        //value1 = myPort.read()-'0'; // read the least significant byte
        int id = value1;
        println(value1);
        println(batteryFlag);
          
    if (id >= 1 && id <= 7) { // is not equal to noise
      if(value1 == 1 || value1 == 2 || value1 == 3 || value1 == 4 || value1 == 5 || value1 == 6 || value1 == 7) {
          // Check If The Timer Has Elapsed
          if( sanitizers[id-1].runTimeout() ) {
            sanitizers[id-1].dispenserTriggered(id);
            myPort.clear();
 
            TableRow newRow = w21ctable.addRow();
            newRow.setInt("SNo", (w21ctable.lastRowIndex())+1);
            //record date and time stamp
            newRow.setInt("PumpID", value1);
            newRow.setString("Pump Name", pumpName);
            newRow.setString("Date", str(day())+("-")+str(month())+("-")+str(year()));          
            newRow.setString("Timestamp", str(hour())+(":")+str(minute())+(":")+str(second()));
            newRow.setInt("Battery Flag", batteryFlag);
           
            
            readingCounter++;
            if(readingCounter % numReadings ==0)//The % is a modulus, a math operator that signifies remainder after division. The if statement checks if readingCounter is a multiple of numReadings (the remainder of readingCounter/numReadings is 0)
            {
              fileName = (Network_Name) +("_") + str(month()) + ("_") + str(day()) + ("_") + str((w21ctable.lastRowIndex())+1) + (".csv"); //this filename is of the form month+day+readingCounter
              saveTable(w21ctable, "W21C/Auto Save/"+fileName); //Woo! save it to your computer. It is ready for all your spreadsheet dreams. 
            }
          }
          else {
            println("Sorry, But Sanitizer #" + str(id) + " Isn't Ready To Be Triggered Again Quite Yet...");
          }
        }
    }
  }
 
} /*   */
