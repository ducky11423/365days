final float HEX_RADIUS = 350;
PShape hex;

void setup() {
  //fullScreen();
  size(800, 800);
  
  hex = createShape();
  
  hex.beginShape();
  hex.fill(0);
  for(int i = 0; i < 7; i++) {
     hex.vertex(cos(2*i*PI/6) * HEX_RADIUS, sin(2*i*PI/6) * HEX_RADIUS);
  }
  hex.endShape(CLOSE);
  
  frameRate(1);
}

void draw() {
  translate(width/2, height/2);
  rotate(PI/6);
  background(255);
  
  fill(0);
  shape(hex);
  
  stroke(255);
  
  pushMatrix();
  rotate(PI/3);
  
  drawLines(0, 0, 1, (frameCount - 1) % 6 + 1);
  popMatrix();
}

void line(float angle, float length) {
  PVector point = PVector.fromAngle(angle).mult(length);
  line(0, 0, point.x, point.y);
}

void drawLines(float x, float y, int depth, int maxDepth){
  pushMatrix();
  translate(x, y);
  
  for(int i = 0; i < 6; i++) {
    strokeWeight(4 / pow(2, depth));
    line(0, HEX_RADIUS / (pow(2, depth)/2));
    if(depth != maxDepth) drawLines(HEX_RADIUS / pow(2, depth), 0, depth + 1, maxDepth);
    rotate(PI/3);
  }
  popMatrix();
}
