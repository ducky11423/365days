final float cycleTime = 600;
final boolean blur = false;

ArrayList<Square> squares;
float nextSquareTime = 0;

void setup() {
  size(1920, 1080);
  frameRate(30);
  
  squares = new ArrayList<Square>();
}

void draw() {
  if(frameCount > nextSquareTime) {
    squares.add(new Square(new PVector(random(width), random(height)), random(100,400), random(2*PI))); 
    nextSquareTime += random(15, 30);
  }
  
  background(0);
  noFill();
  strokeWeight(4);
  
  colorMode(HSB, 1);
  color strokeColor = color(frameCount % cycleTime / cycleTime, 1, 0.5);
  rectMode(RADIUS);

  for(Square square : squares) {
    stroke(strokeColor, square.opacity);
    pushMatrix();
    translate(square.location.x, square.location.y);
    rotate(square.rotation);
    rect(0, 0, square.radius, square.radius);
    popMatrix();
    
    if(!blur) square.opacity -= 0.01;
  }
  
  if(blur) {
    filter(BLUR, 4);
    
    for(Square square : squares) {
      stroke(strokeColor, square.opacity);
      pushMatrix();
      translate(square.location.x, square.location.y);
      rotate(square.rotation);
      rect(0, 0, square.radius, square.radius);
      popMatrix();
      
      square.opacity -= 0.01;
    } 
  }
}
