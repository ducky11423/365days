float[] radii;
float[] targetRadii;
float[] speed;

float sections;

void setup() {
  size(800, 600);
  
  radii = new float[36];
  targetRadii = new float[36];
  speed = new float[36];
  
  for(int i = 0; i < radii.length; i++) {
    radii[i] = random(200, 300); 
    targetRadii[i] = random(200, 300);
    speed[i] = random(3,4);
  }
}

void draw() {
  background(0);
  
  PVector lastPoint = null;
  
  translate(width/2, height/2);
  
  stroke(255);
  
  for(int i = 0; i < radii.length + 1; i++) {
    PVector newPoint = new PVector(cos(radians(360 / radii.length * i)) * radii[i%radii.length], sin(radians(360 / radii.length * i)) * radii[i%radii.length]);
    
    if(lastPoint != null) line(lastPoint.x, lastPoint.y, newPoint.x, newPoint.y);
    
    if(i < radii.length) {
      radii[i] += constrain(targetRadii[i] - radii[i], -speed[i], speed[i]);
      if(abs(targetRadii[i] - radii[i]) < 0.01) {
        targetRadii[i] = random(200, 300);
        speed[i] = random(5);
      }
    }
    
    lastPoint = newPoint;
  }
  
  saveFrame("screenshots/####.png");
}
