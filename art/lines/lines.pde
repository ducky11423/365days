int[] brightnesses;

void setup() {
  size(1920, 1080); 
  
  brightnesses = new int[width];
  for(int i = 0; i < width; i++) {
    brightnesses[i] = 0; 
  }
  
  frameRate(60);
  
  colorMode(HSB, width, 100, 100);
  strokeWeight(1);
}

void draw() {
  if(frameCount % 15 == 0) {   
    int start = (int) random(0, width);
    int size = (int) random(4, min(40, width - start));
    
    for(int i = start; i < start + size; i++) {
      brightnesses[i] = 100; 
    }
  }
  
  loadPixels();

  for(int i = 0; i < width; i++){
    color drawColor = color(i, 100, brightnesses[i]); 
    
    for(int j = 0; j < height; j++) {
      pixels[i + j*width] = drawColor;
    }
    //line(i, 0, i, height);
    
    if(brightnesses[i] > 0) brightnesses[i] -= 1;
  }
  
  updatePixels();
}
