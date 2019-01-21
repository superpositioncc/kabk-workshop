float x1 = 0;
float x2 = 0;

void setup() {
  size(500, 500);
}

void draw() {
  background(0);
  
  noStroke();
  
  fill(255, 0, 0);
  rect(x1, 50, 200, 200);
  
  fill(0, 0, 255);
  rect(x2, 120, 300, 300);
  
  x1 = x1 + 1;
  x2 = x2 - 1;
}
