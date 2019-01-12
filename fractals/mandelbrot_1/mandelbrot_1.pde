final int MAX_ITERATIONS = 100;

color color1;
color color2;

void setup(){
  fullScreen(); 
  
  color1 = color(255, 0, 0);
  color2 = color(255, 0, 255);
}

void draw() {
  background(255);
  for(int i = 0; i < width; i++) {
    for(int j = 0; j < height; j++) {
      float x = map(i, 0, width, -2, 1);
      float y = map(j, 0, height, 1, -1);
      
      int iterations = inSet(x,y);
      if(iterations == MAX_ITERATIONS) fill(0);
      else fill(lerpColor(color1, color2, (float)iterations / MAX_ITERATIONS));
      point(i,j);
    }
  }
}

int inSet(float x, float y) {
  float a = x;
  float b = y;
  
  int loops = 0;
  
  while(loops < MAX_ITERATIONS) {
    if(a*a + b*b > 2) return loops;
    float tempA = a * a - b * b;
    float tempB = 2 * a * b;
    
    a = tempA + x;
    b = tempB + y;
    
    loops++;
  }
  
  return MAX_ITERATIONS;
}
