class RainDrop {
  color rainColour = color(0, 0, 255);
  float drawLength = 20;
  
  PVector position, velocity;
  
  float z;
  
  RainDrop() {
    Initialize();
  }
  
  void Initialize() {
    position = new PVector(random(-300, width+300), random(-200, -100));
    velocity = new PVector(0, random(30, 40));
    
    z = random(1, 4);
  }
  
  void Update() {
    position.add(PVector.div(velocity, z )); 
  }
  
  void Draw() {
    PVector drawOffset = PVector.div(velocity, z);
    stroke(rainColour, 150);
    strokeWeight(4 / z);
    line(position.x, position.y, position.x + drawOffset.x, position.y + drawOffset.y);
  }
}
