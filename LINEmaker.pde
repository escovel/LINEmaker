/* @pjs font="FreeSerif.ttf"; 
 */

/**
 * LINEmaker  || 
 * CLICK INSIDE OF CANVAS TO BEGIN TYPING | 
 *
 *
 * [MOUSE] 
 * Vertical (Y)         : adjust character spacing | 
 * Horizontal (X)       : adjust character alpha value (transparency) | 
 * 
 * [KEY] 
 * A-Z, 1-0, Punc.      : text input (keyboard) | 
 * LEFT ARROW           : delete last typed letter |
 */

import processing.pdf.*;
import java.util.Calendar;

boolean doSave = false;
 
String typedText = "";
 
PFont font;
 
void setup() {
  size(800, 240);
  
  font = createFont("FreeSerif.ttf",48,true); // FreeSerif, 16 Point , anti-aliasing on  
  smooth();
  
}
 
void draw() {
  if (doSave) beginRecord(PDF, timestamp()+".pdf");
  background(255);
  textFont(font,90);
  textAlign(LEFT);
  for (int i = 0; i < typedText.length(); i++) {
  char letter = typedText.charAt(i);
  fill(0, 120+(mouseY/2));
  text(letter, 20+(i*mouseX/20), 145);
  fill(255);
  noStroke();
  rect(780, 0, 20, 240);
  }



  if (doSave) {
    doSave = false;
    endRecord();
    saveFrame(timestamp()+"_##.png");
  }
  
}
 
void keyReleased() {
  if (key != CODED) {
    switch(key) {
    // BACKSPACE does not work in javascript mode, see LEFT fix below
    case BACKSPACE:
      typedText = typedText.substring(0,max(0,typedText.length()-1));
      break;
    case ESC:
    case DELETE:
      break;
    default:
      typedText += str(key);
    }
  }
  // export pdf and png
  if (keyCode == CONTROL) doSave = true;
  // this code is a fix for the BACKSPACE javascript mode bug
  if (keyCode == LEFT) {
     typedText = typedText.substring(0,max(0,typedText.length()-1));
  }
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

