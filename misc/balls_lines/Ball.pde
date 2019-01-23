class Ball {
  PVector position;
  PVector velocity;
  
  float lineLength;
  float size;
  
  boolean bounce = true;

  Ball() {
    position = new PVector(random(width), random(height));
    velocity = PVector.fromAngle(random(2 * PI)).mult(random(2));
    
    lineLength = random(10, 350);
    size = map(lineLength, 10, 350, 10, 20);
    
    if(random(1) < 0.5) bounce = false;
  }
  
  void Update() {
    if(bounce) {
      if(position.x < 0 || position.x > width) {
        velocity.x *= -1; 
      }
      
      if(position.y < 0 || position.y > height) {
        velocity.y *= -1; 
      }  
    } else {
      //println(position);
      position.x = wrap(position.x, 0, width);
      position.y = wrap(position.y, 0, height);
    }
  
    
    
    position.add(velocity);
  }
  
  void Render() {
    ellipseMode(CENTER);
    fill(255, 100);
    stroke(255, 100);
    ellipse(position.x, position.y, size, size);
  }
}

float wrap(float a, float min, float max) {
  while(a < min) {
    a += max - min; 
  }
  
  while(a > max) {
    a -= max - min; 
  }
  
  return a;
}
