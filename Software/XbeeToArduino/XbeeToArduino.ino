#include <XBee.h>
#include <SoftwareSerial.h>

// Setup pin definitions for XBee shield
uint8_t recv = 2;
uint8_t trans = 3;
SoftwareSerial soft_serial(recv, trans);

// Instantiate an instance of the XBee library
XBee xbee = XBee();

// Instantiate an instance of the IO sample class
ZBRxIoSampleResponse ioSample = ZBRxIoSampleResponse();

void setup() {
  Serial.begin(9600);
  while (!Serial); // Leonardo boards need to wait for Serial to start
  soft_serial.begin(9600);
  xbee.setSerial(soft_serial);
}

// Get address and print it
void get_address(ZBRxIoSampleResponse *ioSample) {
//  Serial.print("Received data from address: ");
//  Serial.print(ioSample->getRemoteAddress64().getMsb(), HEX);
//  Serial.print(ioSample->getRemoteAddress64().getLsb(), HEX);
//  Serial.println("");
}

// Get voltage at signal pin DI03 and print it
void get_temperature(ZBRxIoSampleResponse *ioSample) {
  int Address_LSB = (ioSample->getRemoteAddress64().getLsb());
  String Address = String(Address_LSB, HEX);
     //Serial.print("Last four didgits of HEX Address: ");
     //Serial.print(Address); Serial.println(" ");
     //Serial.print("Decimal number to use in Switch Statement: ");
  //Serial.print(Address_LSB); Serial.println(" ");Serial.println(" ");
  //int Packet_length = (ioSample->getPacketLength());
  
  float adc_data = ioSample->getAnalog(3);
  float temperatureC = ((adc_data * 1200.0 / 1024.0) / 1000.0);
  
  int ref = xbee.getResponse().getFrameData()[17]<<8;
  ref += xbee.getResponse().getFrameData()[18]<<8;
  float volts = (float(ref) * float(1200.0 / 1024.0))/1000.0;

  switch (Address_LSB) {
    case 18975:
     if (temperatureC != 0) {
       if(volts == 3.3){ Serial.println("A");}
       else{Serial.println("B");}
     }
      //Serial.println(temperatureC);
      break;

    case 19004:
      if (temperatureC != 0) {
       if(volts == 3.3){ Serial.println("C");}
       else{Serial.println("D");}
      }
      break;

    case 26410:
     if (temperatureC != 0) {
       if(volts == 3.3){ Serial.println("E");}
       else{Serial.println("F");}
     }
      break;

     case 19807:
     if (temperatureC != 0) {
       if(volts == 3.3){ Serial.println("G");}
       else{Serial.println("H");}
     }
      break;

     case 44402:
     if (temperatureC != 0) {
       if(volts == 3.3){ Serial.println("I");}
       else{Serial.println("J");}
     }
     break;

    case 44397:
     if (temperatureC != 0) {
       if(volts == 3.3){ Serial.println("K");}
       else{Serial.println("L");}
     }
      //Serial.println(temperatureC);
     break;

    case 44399:
     if (temperatureC != 0) {
       if(volts == 3.3){ Serial.println("M");}
       else{Serial.println("N");}
     }
      //Serial.println(temperatureC);
      break;
       
    default:
      Serial.println("default break");
      break;
  }

  //Serial.print(temperatureC);
  // Serial.print("V; ");

}


// Get supply voltage and print it
void get_supply_voltage() {
  //##################//
//  Serial.print("Supply voltage is");
//  int ref = xbee.getResponse().getFrameData()[17]<<8;
//  ref += xbee.getResponse().getFrameData()[18]<<8;
//////  Serial.println(ref);
//  float volts = (float(ref) * float(1200.0 / 1024.0))/1000.0;
//  Serial.print(" = ");
//  Serial.print(volts);
//  Serial.println("V.");
//
// Serial.print("packet length is ");
// Serial.println(ioSample.getPacketLength(), DEC);
//
//   // this is the actual data you sent
//    Serial.println("Received Data: ");
//    for (int i = 0; i < ioSample.getDataLength(); i++) {
//    Serial.print(ioSample.getData()[i], HEX);
//    Serial.print(' ');}
}

void loop() {
  //attempt to read a packet
  xbee.readPacket();
  if (xbee.getResponse().isAvailable()) {
    // got something
    if (xbee.getResponse().getApiId() == ZB_IO_SAMPLE_RESPONSE) {
      // Get the packet
      xbee.getResponse().getZBRxIoSampleResponse(ioSample);
      // Read and display data
      //Serial.print("IO Sample received!");
      get_address(&ioSample);
      get_temperature(&ioSample);
      get_supply_voltage();
    }
    else {
      //Serial.print("Expected I/O Sample, but got ");
      //Serial.print(xbee.getResponse().getApiId(), HEX);
    }
  } else if (xbee.getResponse().isError()) {
    Serial.print("Error reading packet. Error code: ");
    Serial.println(xbee.getResponse().getErrorCode());
  }
}

