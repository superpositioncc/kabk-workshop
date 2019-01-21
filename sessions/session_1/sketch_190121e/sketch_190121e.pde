import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;

Capture myWebcam;
OpenCV opencv;
Rectangle[] detectedFaces;

void setup() {
  size(1280, 720);
  
  myWebcam = new Capture(this, width, height, 30);
  myWebcam.start();
  
  opencv = new OpenCV(this, width, height);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
}

void draw() {
  if (myWebcam.available()) {
    myWebcam.read();
  }
  
  opencv.loadImage(myWebcam);
  detectedFaces = opencv.detect();
  
  image(myWebcam.get(), 0, 0);
  
  for (int i=0; i<detectedFaces.length; i++) {
    Rectangle face = detectedFaces[i];
    
    fill(0);
    noStroke();
    
    rect(face.x, face.y, face.width, face.height);
  }
}
