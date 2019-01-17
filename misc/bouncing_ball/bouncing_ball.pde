final int BALL_RADIUS = 20;
final float DAMPENING = 0.95;

PVector pos, vel, gravity;

float lastTime = 0;

void setup() {
  size(800, 600);
  pos = new PVector(200, 200);
  vel = new PVector(200, 0);
  gravity = new PVector(0, 150);
}

void draw(){
  background(255);
  fill(0, 0, 255);
  
  float thisTime = millis() / 1000.0;
  
  float deltaTime = thisTime - lastTime;
  lastTime = thisTime;
  
  vel.add(PVector.mult(gravity, deltaTime));
  pos.add(PVector.mult(vel, deltaTime));

  ellipseMode(RADIUS);
  ellipse(pos.x, pos.y, BALL_RADIUS, BALL_RADIUS); 
  
  if(pos.x < BALL_RADIUS || pos.x > width - BALL_RADIUS) {
    pos.x = constrain(pos.x, BALL_RADIUS, width - BALL_RADIUS);
    vel.x = -vel.x * DAMPENING; 
  }
  
  if(pos .y > height - BALL_RADIUS) {
    pos.y = height - BALL_RADIUS;
    vel.y = -vel.y * DAMPENING; 
  }
}

void keyPressed() {
  vel = PVector.mult(PVector.fromAngle(random(2 * PI)), 400);
}
