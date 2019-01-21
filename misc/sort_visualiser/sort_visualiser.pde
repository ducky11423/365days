// array to be sorted

float[] data;

int currentIndex; // current indedx that is up to be sorted ?
void setup(){
  size(800, 600); 
  
  data = new float[width];
  for(int i = 0; i < data.length; i++) {
     data[i] = map(i, 0, width, 0, height);
  }
  
  // shuffle the data
  for(int i = 0; i < 100000; i++) {
    int index1 = (int) random(data.length); 
    int index2 = (int) random(data.length);
    
    float temp = data[index1];
    data[index1] = data[index2];
    data[index2] = temp;
  }
  
  currentIndex = 0;
  
  frameRate(9999);
}

void draw(){
  colorMode(RGB, 255);
  background(255, 255, 255, 1);
  
  fill(0);
  stroke(0);
  text("Selection Sort", 20, 20);
  
  colorMode(HSB, 100);
  strokeWeight(1);
  
  int lowestIndex = -1;
  float lowest = 9999999;
  
  for(int i = currentIndex; i < data.length; i++) {
    if(data[i] < lowest) {
      lowestIndex = i;
      lowest = data[i]; 
    }
  }
  
  data[lowestIndex] = data[currentIndex];
  data[currentIndex] = lowest;
  
  currentIndex++;
  
  if(currentIndex == data.length) {
    setup();
  }
  
  
  for(int i = 0; i < data.length; i++){
    float value = data[i];
    stroke(map(value, 0, height, 0, 100), 100, 100);
    line(i, height, i, height - value);
  }
  
}
