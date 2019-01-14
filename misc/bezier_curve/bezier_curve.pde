PVector[] controlPoints;
float t = 0;

ArrayList<PVector> drawLocations;

void setup() {
  size(600, 600); 
  
  controlPoints = new PVector[5];
  controlPoints[0] = new PVector(150, 100);
  controlPoints[1] = new PVector(450, 100);
  controlPoints[2] = new PVector(450, 500);
  controlPoints[3] = new PVector(150, 500);
  controlPoints[4] = new PVector(50, 300);
  
  background(255);
  
  rectMode(CENTER);
  for(PVector loc : controlPoints) {
      rect(loc.x, loc.y, 5, 5);
  }
  
  drawLocations = new ArrayList<PVector>();
  
}

void draw(){
  background(255);
  
  stroke(0);
  
  PVector loc = myBezierPoint(controlPoints, t);
  
  drawLocations.add(loc);
  
  for(PVector _loc : drawLocations){
    point(_loc.x, _loc.y);
  }
  
  stroke(0, 0, 255);
  rect(loc.x, loc.y, 5, 5);
  
  t += 0.005;
  
  if(t > 1) {
    drawLocations.clear();
    t = 0;
  }
}



PVector myBezierPoint(PVector[] controlPoints, float t){
  if(controlPoints.length == 1) return controlPoints[0];
  
  PVector[] newPoints = new PVector[controlPoints.length - 1];
  for(int i = 0; i < newPoints.length; i++){
    PVector point1 = controlPoints[i];
    PVector point2 = controlPoints[i+1];
    line(point1.x, point1.y, point2.x, point2.y);
    newPoints[i] = PVector.lerp(controlPoints[i], controlPoints[i+1],t);
  }
  return(myBezierPoint(newPoints, t));
}
