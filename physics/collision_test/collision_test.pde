ArrayList<EdgeCollider> edges;

PVector ballPos;
PVector ballVel;

PVector gravity;

float ballRadius = 10;
float ballMass = 100;
void setup(){
  size(800, 600);
  
  edges = new ArrayList<EdgeCollider>();
  edges.add(new EdgeCollider(new PVector(100, 50), new PVector(700, 50)));
  edges.add(new EdgeCollider(new PVector(100, 350), new PVector(700, 550)));
  edges.add(new EdgeCollider(new PVector(100, 250), new PVector(700, 150)));
  edges.add(new EdgeCollider(new PVector(50, 100), new PVector(50, 500)));
  
  ballPos = new PVector(0, 0);
  ballVel = new PVector(0, 0);
  
  gravity = new PVector(0, 0.5);
}

void draw() {
  background(255);
  
  // Calculate
  
  PVector netForce = new PVector(0, 0);
  netForce.add(PVector.mult(gravity, ballMass));
  
  if(mousePressed) {
    ballPos.x = mouseX;
    ballPos.y = mouseY;
    
    ballVel.x = 0;
    ballVel.y = 0;
  }

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
    
    // if collding
    if(pc.magSq() < pow(ballRadius,2)) {
      
      // make the ball bounce off (this isn't done with forces because to be honest i dont know how)
      float newVelocityAngle = PVector.angleBetween(ballVel, pc) * ((pc.heading() > ballVel.heading()) ? 1 : -1) + pc.heading();
      float newVelocityMagnitude = ballVel.mag() * -0.95;
      PVector newVelocity = PVector.fromAngle(newVelocityAngle).mult(newVelocityMagnitude);
    
      ballVel = newVelocity;
    
      
      // angle of component of force against surface thats perp.
      float forcePerpAngle = pc.heading();
      
      // the normal force applied on the object by the wall
      float normalAngle = forcePerpAngle - PI;
      float normalMagnitude = abs(netForce.mag() * cos(forcePerpAngle - PI/2));
      PVector normalForce = PVector.fromAngle(normalAngle).mult(normalMagnitude);
      
      // the force pulling the object downhill
      // i dont really know how this works, but it does so i don't complain
      float downhillAngle = normalAngle + PI/2*((normalAngle < -PI / 2) ? -1: 1);
      float downhillMagnitude = abs(netForce.mag() * sin(forcePerpAngle - PI/2));
      PVector downhillForce = PVector.fromAngle(downhillAngle).mult(downhillMagnitude);
      
      stroke(255, 0, 255);
      line(ballPos.x, ballPos.y, ballPos.x + normalForce.x, ballPos.y + normalForce.y);
      line(ballPos.x, ballPos.y, ballPos.x + downhillForce.x, ballPos.y + downhillForce.y);
      
      netForce.add(normalForce);
      netForce.add(downhillForce);
      
      //PVector moveVector = pc.copy().limit(pc.mag() - ballRadius);
      //ballPos.add(moveVector);
    }
    
    stroke(255, 0, 0);
    strokeWeight(2);
    //line(ballPos.x, ballPos.y, ballPos.x + pc.x, ballPos.y + pc.y);
  }
  
  ballVel.add(PVector.div(netForce, ballMass));
  ballPos.add(ballVel);

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
