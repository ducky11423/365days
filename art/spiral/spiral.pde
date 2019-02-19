float rotation = 0;
float n = 0;

void setup() {
  size(1920, 1080);
  
  background(0);
  //frameRate(4);
}

void draw() {
  translate(width/2, height/2);
  rotate(rotation);
  
  rectMode(CORNER);
  stroke(0, 0, 255);
  noFill();
  
  rect(0, 0, 100 + frameCount, 100 + frameCount);
  
  rotation += PI / 64.0;
  
  // this helps to eliminate the accumalating floating point error by snapping the rotation to the propper value everynow and then
  if(rotation > n * PI / 4) {
    rotation = n * PI / 4;
    n++;
  }
}
