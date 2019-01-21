import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

PShader shader;
Capture capture;
OpenCV opencv;
Rectangle[] faces;

void setup() {
  size(1280, 720, P2D);

  textureWrap(REPEAT);

  shader = loadShader("shader.frag");
  shader.set("resolution", float(width), float(height));

  capture = new Capture(this, width, height, 30);
  capture.start();

  opencv = new OpenCV(this, width / 2, height / 2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
}

void draw() {
  background(0);

  if (capture.available()) {
    capture.read();
  }

  image(capture.get(), 0, 0);

  PImage small = resizeImage(capture, width / 2, height / 2);
  opencv.loadImage(small);
  faces = opencv.detect();

  if (faces.length > 0) {
    shader.set("faceDetected", true);
    shader.set("face", 
      (float) faces[0].x * 2, 
      (float) faces[0].y * 2, 
      (float) faces[0].width * 2, 
      (float) faces[0].height * 2
      );
  } else {
    shader.set("faceDetected", false);
  }

  shader(shader);
}

PImage resizeImage(PImage image, int newWidth, int newHeight) {
  PImage resized = image.get();
  resized.resize(newWidth, newHeight);

  return resized;
}
