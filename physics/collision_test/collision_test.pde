ArrayList<EdgeCollider> edges;

PVector ballPos;
float ballRadius = 10;

void setup(){
  size(800, 600);
  
  edges = new ArrayList<EdgeCollider>();
  edges.add(new EdgeCollider(new PVector(100, 50), new PVector(700, 50)));
  edges.add(new EdgeCollider(new PVector(100, 350), new PVector(700, 550)));
  edges.add(new EdgeCollider(new PVector(50, 100), new PVector(50, 500)));
  
  ballPos = new PVector(0, 0);

}

void draw() {
  background(255);
  
  // Calculate
  
  ballPos.add(PVector.sub(new PVector(mouseX, mouseY), ballPos).limit(5));

  for(EdgeCollider edge : edges) {
    // for the sake of making the equations easier to read
    PVector a = edge.start; 
    PVector b = edge.end;
    PVector p = ballPos;
    
    
    // vector from a to b and unit vector of that
    PVector ab = PVector.sub(b, a);
    PVector abNorm = ab.copy();
    abNorm.normalize();
    
    // vector from a to p
    PVector ap = PVector.sub(p, a);
    
    // ap dot abNorm -> scalar projection of ap in the direction of b (this is the un-normed paramater)
    float apDotAbNorm = ap.dot(abNorm);
    
    // the parameter of the point on the line a + ab*t that is perp. to p
    float parameter = norm(apDotAbNorm, 0, ab.mag());
    
    // the point on the line ab that is closest to p. this is could be one of the two ends
    PVector c;
    
    if(parameter < 0) {
      c = a;
    } else if (parameter > 1) {
      c = b;
    } else {
      c = PVector.add(a, PVector.mult(ab, parameter)); 
    }
    
    // the line from p to c
    PVector pc = PVector.sub(c, p);
    
    stroke(255, 0, 0);
    strokeWeight(2);
    line(ballPos.x, ballPos.y, ballPos.x + pc.x, ballPos.y + pc.y);
  }
  
  
  // Render loop

  // draw the circle
  stroke(0, 0, 255);
  strokeWeight(4);
  ellipseMode(RADIUS);
  ellipse(ballPos.x, ballPos.y, ballRadius, ballRadius);
  
  for(EdgeCollider edge : edges) {
    edge.Render(); 
  }
}
