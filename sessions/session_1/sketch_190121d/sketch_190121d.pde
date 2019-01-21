import processing.video.*;

Capture myWebcam;

void settings() {
  size(1280, 720);
}

void setup() {
  myWebcam = new Capture(this, width, height, 30);
  myWebcam.start();
}

void draw() {
  if (myWebcam.available()) {
    myWebcam.read();
  }
  
  image(myWebcam.get(), 0, 0);
}
