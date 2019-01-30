int lastMouseX, lastMouseY;

void setup() {
  size(1920, 1080); 

  background(255);
}

void draw() {
  if(mousePressed) {
    if(mouseButton == LEFT) {
      if(lastMouseX == -1) lastMouseX = mouseX;
      if(lastMouseY == -1) lastMouseY = mouseY;
      
      fill(0);
      stroke(0);
      strokeWeight(10);
      line(mouseX, mouseY, lastMouseX, lastMouseY);
      
      lastMouseX = mouseX;
      lastMouseY = mouseY;
    } else {
      loadPixels();
      floodFill(mouseX, mouseY, null); 
      updatePixels();
    }
    
    
  } else {
    lastMouseX = -1; 
    lastMouseY = -1; 
  }
}



void floodFill(int x, int y, color fill) {
  println(pixels[x+y*width]==color(255));
}
