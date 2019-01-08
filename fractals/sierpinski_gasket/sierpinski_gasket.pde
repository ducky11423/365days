PVector[] vertices;
PVector point;

void setup() {
  size(800, 800); 
  
  vertices = new PVector[3];
  vertices[0] = new PVector(400, 140);
  vertices[1] = new PVector(100, 660);
  vertices[2] = new PVector(700, 660);
  
  point = vertices[0];
  background(255);
}

void draw(){
  int n = (int) random(3);
 
  point = PVector.lerp(point, vertices[n], 0.5);
  point(point.x, point.y);
}
