color c1;
color c2;

void setup() {
  size(800, 600); 
  
  c1 = color(66, 209, 206);
  c2 = color(252, 71, 68);
  
  frameRate(1);
  
  draw();
}

void draw() {
  background(lerpColor(c1, c2, 0.5));
  scale(10);
  for(int i = 0; i < width/10; i++) {
    for(int j = 0; j < height/10; j++) {
      stroke(lerpColor(c1, c2, random(1)));
       point(i, j);
    }
  }
}
