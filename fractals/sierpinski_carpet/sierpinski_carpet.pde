ArrayList<PVector> locations;
int squareSize = 243;

void setup(){
  size(729, 729);
  background(color(0, 0, 255));
  
  locations = new ArrayList<PVector>();
  locations.add(new PVector(width/2, height/2));
  
  frameRate(1);
}

void draw(){
  fill(255);
  noStroke();
  rectMode(CENTER);
  
  ArrayList<PVector> nextLocations = new ArrayList<PVector>();
  
  for(PVector loc : locations) {
    int x = (int) loc.x;
    int y = (int) loc.y;
    rect(x, y, squareSize, squareSize);
    
    nextLocations.add(new PVector(x - squareSize, y - squareSize));
    nextLocations.add(new PVector(x, y - squareSize));
    nextLocations.add(new PVector(x + squareSize, y - squareSize));
    nextLocations.add(new PVector(x - squareSize, y));
    nextLocations.add(new PVector(x + squareSize, y));
    nextLocations.add(new PVector(x - squareSize, y + squareSize));
    nextLocations.add(new PVector(x, y + squareSize));
    nextLocations.add(new PVector(x + squareSize, y + squareSize));
  }
  
  saveFrame("####.png");
  
  locations = nextLocations;
  squareSize /= 3;
  
  if(squareSize == 0){
    noLoop(); 
  }
}
