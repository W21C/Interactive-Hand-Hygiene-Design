
// -----------------------------
// SETUP
// -----------------------------

void setup() {
  // Screen
  size(displayWidth, displayHeight, JAVA2D);
  frame.setResizable(true);
  smooth();

  // Font
  large  = loadFont("Fonts/Knockout-HTF49-Liteweight-96.vlw"); 
  medium = loadFont("Fonts/Knockout-HTF49-Liteweight-72.vlw"); 
  small  = loadFont("Fonts/Knockout-HTF49-Liteweight-48.vlw"); 
  
  textPositionX = int(width * .15);
  textPositionY = int(height * .15);
  datePositionX = int(width - (width * .15));
  datePositionY = int(height *.20);
  timePositionX = int(width - (width * .15));
  timePositionY = int(height * .15);
  
  dailyLabelPositionX = int(width / 2);
  dailyLabelPositionY = int(height - (height * .15));
  weeklyLabelPositionX = int(width / 2);
  weeklyLabelPositionY = int(height - (height * .15));
  monthlyLabelPositionX = int(width / 2);
  monthlyLabelPositionY = int(height - (height * .15)); 

  // Serial
  if(useSerial == true) {
    //String portName = Serial.list()[portIndex];
    println(Serial.list());
    //println(" Connecting to -> " + Serial.list()[portIndex]); 
    //myPort = new Serial(this, portName, 9600); 
    myPort = new Serial(this, "COM7", 9600); // <--- Change COM# to whatever number the Arduino is connected to, as listed in the Control Panel>Device Manager
  }
  
  // Hands
  hands = new ArrayList();
  
  // Sanitizers
  for(int i = 0; i < sanitizers.length; i++) {
    // Id, Color
    sanitizers[i] = new Sanitizer(i, palette[i]); 
  }

  // Tweening
  anim = new Tween(this, 6, Tween.SECONDS, Shaper.QUADRATIC);

  // Audio
  minim = new Minim(this) ;
  minim.debugOff();
  for(int i = 0; i < samples.length; i++) {
    samples[i] = minim.loadSample("Sounds/" + i + ".WAV", 128) ;
  }

  // Logos
  eculogo = loadImage("Logos/EmilyCarr_White_Logo_Large.png");
  vchlogo = loadImage("Logos/W21C Logo.png");
  
  // Tables
  try {
    dailyTable = loadTable("Saved/dailyTable.tsv");  
    weeklyTable = loadTable("Saved/weeklyTable.tsv");
    monthlyTable = loadTable("Saved/monthlyTable.tsv");
  }
  catch(Exception e) {
    e.printStackTrace();
    println("Couldn't Load The Tables :/ "); 
  }
  
  // Read Tables
  readDay();
  readWeek();
  readMonth();
  
  // Calendar
  getCalendar();


  // Misc
  start = millis();
  ellipseMode(CENTER); 
  
  // Chart
  baseLineX = textPositionX;
  baseLineY = int(height - (height * .30));
  divStartX = textPositionX;
  divEndX = width - textPositionX;
  divOneY = int(height - (height * .40));
  divTwoY = int(height - (height * .50)); 
  divThreeY = int(height - (height * .60));
  
 
  //W21C Data logging
  w21ctable.addColumn("SNo"); 
  w21ctable.addColumn("PumpID");
  w21ctable.addColumn("Pump Name");
  w21ctable.addColumn("Date");
  w21ctable.addColumn("Timestamp");
  w21ctable.addColumn("Battery Flag");
  
  
  
  println("");
  println("---- End Of Setup ----");
  println("");
  
} /* End Of Setup() */




