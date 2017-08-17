/*
 HandWashing Program
 by Haig Armen & Jesse Scott
 Emily Carr University of Art + Design | www.ecuad.ca
 v 2.0
*/ 

// -----------------------------
// IMPORTS
// -----------------------------

import processing.serial.*;
import java.awt.Frame;
import megamu.shapetween.*;
import ddf.minim.* ;

import java.io.File;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.awt.event.KeyEvent;

// -----------------------------
// DECLARATIONS
// -----------------------------

Serial myPort;

ArrayList hands;
TheHand tempHand; 
Sanitizer[] sanitizers = new Sanitizer[7];

PFont large, medium, small;
PImage eculogo;
PImage vchlogo;
PShape handImg;

Table dailyTable, weeklyTable, monthlyTable, yearlyTable;

Table w21ctable= new Table();
int numReadings = 50; //keeps track of how many readings you'd like to take before writing the file. 
int readingCounter = 0; //counts each reading to compare to numReadings. 
String pumpName;
String fileName;
String Network_Name = "Network_2016";
String SerialIn; 
int batteryFlag = 1;

Tween anim;

Minim minim;
AudioSample au_player;
AudioSample[] samples = new AudioSample[7];

Calendar calendar;
java.util.Date date;


// -----------------------------
// GLOBAL VARIABLES
// -----------------------------

// Display State
int halfTimeOut = 5;
int fullTimeOut = 15;
int drawState = 1;
int subDrawState = 1;
boolean drawHands = true;

// Hand Counts
int allHandsThisHour  = 0;
int allHandsThisDay   = 0;
int allHandsThisWeek  = 0;
int allHandsThisMonth = 0;
int allHandsThisYear  = 0;

int numHandsThisHour[]   = new int[7];
int numHandsThisDay[]   = new int[7];
int numHandsThisWeek[]  = new int[7];
int numHandsThisMonth[] = new int[7];
int numHandsPerDayThisMonth[] = new int[31];
int numHandsPerDayThisWeek[] = new int[7];
int numHandsThisYear[]  = new int[7]; 

// Daily Table
int totalRow = 7;
int totalCol = 25;

int unitColumn = 0;
int dayColumn = 1;
int weekColumn = 2;
int monthColumn = 3;


// Colours
int bgColor = 0;

color[] palette = {
  color(255, 245, 0, 201),    // Yellow
  color(255, 0, 153, 201),   // Magenta
  color(102, 255, 0, 201),    // Green
  color(0, 153, 255, 201),  // Blue
  color(204, 0, 255, 201),  // Purple
  color(255, 102, 0, 201),   // Orange
  color(245,51,71,201)
};
  
int colorNumber = 0;
int newColor;
color color1 = color(8, 90, 166);
color unitColors[] = new color[6];

color chartColor = color(255, 0, 255);       // Magenta
color dropShadowColor = color(7, 89, 164);   // PSD
color textColor = color(255, 255, 255);
  
// XY
int newX = width/2;
int newY = height/2;
int prevX = width/2;
int prevY = height/2;

// Time / Date / Text / Label Position
int datePositionX, datePositionY;
int timePositionX, timePositionY;
int textPositionX, textPositionY;

int dailyLabelPositionX, dailyLabelPositionY;
int weeklyLabelPositionX, weeklyLabelPositionY;
int monthlyLabelPositionX, monthlyLabelPositionY;

// Text Size
int countTextSize = 96;
int dateTextSize = 96;
int dailyTextSize = 48;
int weeklyTextSize = 48;
int monthlyTextSize = 48;

// Labels
String dailyLabel;
String weeklyLabel;
String monthlyLabel;

// Chart
int baseLineX, baseLineY;
int divStartX, divEndX;
int divOneY, divTwoY, divThreeY;

// Time
String theHour;
String theMin;
String theSec;
String theMeridiem;
String time;

// Date
String theDate;
String theYear;
String theMonth;
String theDay;
  
// Timer
int start;
int count = 0;
int tempSec = 0;
int tempMin = 0;
int lastMin = 0;
int maxTempCount = 600; 
int maxVerticalHands = 30;

// Serial
short portIndex = 1;
char HEADER = 'H';
int value1, value2;
boolean useSerial = true;

float a = 2.5, b = 3.144;
int x = width/2, y = height/2;
 
// Opacity
int op1 = 65;







 












