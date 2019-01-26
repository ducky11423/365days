PVector[] vertices;
PVector point;

int n_sides = 5;

void setup() {
  size(800, 800); 
  
  vertices = new PVector[n_sides];
  for(int i = 0; i < n_sides; i++) {
    vertices[i] = new PVector(cos(2 * PI * i / n_sides) * 350, sin(2 * PI * i / n_sides) * 350);
  }
  
  point = vertices[0];
  background(255);
}

void draw(){
  
  translate(width/2, height/2);
  rotate(-PI / 2);
 
  loadPixels();
  
  for(int i = 0; i < 25000; i++) {
    int n = (int) random(n_sides);
    point = PVector.lerp(point, vertices[n], 0.5);
    point(point.x, point.y);
    int x = (int) point.x;
    int y = (int) point.y;
    
    if(y * width + x > 0) pixels[y * width + x] = 0;
  }
}
