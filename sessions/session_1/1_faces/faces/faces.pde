import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;

Capture webcam;
OpenCV opencv;
Rectangle[] faces;

void setup() {
  size(1280, 720);

  webcam = new Capture(this, width, height, 30);
  webcam.start();

  opencv = new OpenCV(this, width / 2, height / 2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
}

void draw() {
  background(0);

  if (webcam.available()) {
    webcam.read();
  }

  image(webcam, 0, 0);

  ///

  PImage smallWebcam = resizeImage(webcam, width / 2, height / 2);
  opencv.loadImage(smallWebcam);

  faces = opencv.detect();

  if (faces != null) {
    for (int i=0; i<faces.length; i++) {
      int x = faces[i].x * 2;
      int y = faces[i].y * 2;
      int w = faces[i].width * 2;
      int h = faces[i].height * 2;

      noStroke();
      fill(0);

      for (int j=0; j<50; j++) {
        int fromX = floor(noise(i + j, 0) * w + x - w / 2);
        int fromY = floor(noise(0, i + j) * h + y - h / 2);
        int fromW = floor(noise(i) * w);
        int fromH = floor(noise(j) * h);

        int toX = floor(noise(i - j, 1233) * w + x - w / 2);
        int toY = floor(noise(123, i - j) * h + y - h / 2);

        PImage rect = webcam.get(fromX, fromY, fromW, fromH);
        image(rect, toX, toY);
      }
    }
  }
}

PImage resizeImage(PImage image, int newWidth, int newHeight) {
  PImage resized = image.get();
  resized.resize(newWidth, newHeight);

  return resized;
}
