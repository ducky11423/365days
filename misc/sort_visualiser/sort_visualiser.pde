String[] sorts;
int sort = 0;

float maxValue;

// array to be sorted
float[] data;

int passes; // current index that is up to be sorted ? (used for different things in different algos. should probably name better)

void setup(){
  size(800, 600); 
  
  sorts = new String[4];
  sorts[0] = "Selection Sort";
  sorts[1] = "Bubble Sort";
  sorts[2] = "Cocktail Sort";
  sorts[3] = "Odd-Even Sort";
  
  maxValue = height - 100;
  
  data = new float[width];
  for(int i = 0; i < data.length; i++) {
     data[i] = map(i, 0, width, 0, maxValue);
  }
  
  // shuffle the data
  for(int i = 0; i < 100000; i++) {
    int index1 = (int) random(data.length); 
    int index2 = (int) random(data.length);
    
    swap(index1, index2);
  }
  
  passes = 0;
  
  frameRate(9999);
}

void keyPressed() {
  int n = int(key) - 49;
  if(n >= 0 && n < sorts.length) {
    sort = n;
    setup();
  }
}

void draw(){  
  
  // sorting 
  
  if(sorts[sort] == "Selection Sort") {
    int lowestIndex = -1;
    float lowest = 9999999;
    
    for(int i = passes; i < data.length; i++) {
      if(data[i] < lowest) {
        lowestIndex = i;
        lowest = data[i]; 
      }
    }
    
    data[lowestIndex] = data[passes];
    data[passes] = lowest;
    
    passes++;
    
    if(passes == data.length) {
      setup();
    }
  } else if(sorts[sort] == "Bubble Sort") {
    boolean sorted = true;
    for(int i = 0; i < data.length - 1 -passes; i++) {
      if(data[i] > data[i+1]) {
        sorted = false; 
        
        swap(i, i+1);
      }
    }
    
    passes++;
    
    if(sorted) {
      setup(); 
    }
  } else if(sorts[sort] == "Cocktail Sort") {
    boolean sorted = true;
    for(int i = 0; i < data.length - 1 -passes; i++) {
      if(data[i] > data[i+1]) {
        sorted = false; 
        
        swap(i, i+1);
      }
    }
    
    for(int i = data.length - 2; i > passes ; i--) {
      if(data[i] < data[i-1]) {
        sorted = false; 
        
        swap(i, i-1);
      }
    }
    
    passes++;
    
    if(sorted) {
      setup(); 
    }
  } else if(sorts[sort] == "Odd-Even Sort") {
    boolean sorted = true;
    for(int i = 0; i < data.length - 1; i += 2) {
      if(data[i] > data[i+1]) {
        sorted = false; 
        
        swap(i, i+1);
      }
    }
    
    for(int i = 1; i < data.length - 1; i += 2) {
      if(data[i] > data[i+1]) {
        sorted = false; 
        
        swap(i, i+1);
      }
    }
    
    passes++;
    
    if(sorted) {
      setup(); 
    }
  }
  
  // drawing
  colorMode(RGB, 1);
  background(1);
  
  // draw the data
  colorMode(HSB, 100);
  strokeWeight(1);
    
  for(int i = 0; i < data.length; i++){
    float value = data[i];
    stroke(map(value, 0, maxValue, 0, 100), 100, 100);
    line(i, maxValue, i, maxValue - value);
  }
 
 
 
  colorMode(RGB, 255);
  
  fill(112, 128, 144);
  stroke(112, 128, 144);
  rect(0, height - 100, width, height);
  
  fill(255);
  
  textSize(20);
  
  for(int i = 0; i < sorts.length; i++) {
    if(i == sort) fill(255, 0, 0);
    else fill(255);
    int xPos = 10 + (width / 3) * floor(i / 3);
    int yPos = height - 75 + 25 *(i % 3);
    text( (i + 1) + " - " + sorts[i], xPos, yPos);
  }
}

void swap(int index1, int index2) {
  float temp = data[index1];
  data[index1] = data[index2];
  data[index2] = temp;
}
