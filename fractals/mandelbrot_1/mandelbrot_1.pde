void setup(){
  fullScreen(); 
}

void draw() {
  background(255);
  for(int i = 0; i < width; i++) {
    for(int j = 0; j < height; j++) {
      float x = map(i, 0, width, -2, 1);
      float y = map(j, 0, height, 1, -1);
      
      if(inSet(x, y)) point(i, j);   
    }
  }
}

boolean inSet(float x, float y) {
  float a = x;
  float b = y;
  
  int loops = 0;
  
  while(loops < 64) {
    if(a*a + b*b > 2) return false;
    float tempA = a * a - b * b;
    float tempB = 2 * a * b;
    
    a = tempA + x;
    b = tempB + y;
    
    loops++;
  }
  
  
  return true;
}
