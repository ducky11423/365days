Particle[][] particles;

color noPressure = color(255);
color highPressure = color(255, 0, 0);

float damp = 1;

int particleSize = 20;

void setup() {
  size(800, 600);
  
  particles = new Particle[width/particleSize][];
  
  for(int i = 0; i < particles.length; i++) {
    particles[i] = new Particle[height/particleSize];
    for(int j = 0; j < particles[i].length; j++) {
      particles[i][j] = new Particle();
      particles[i][j].position = new PVector(i * particleSize + 5, j * particleSize + 5);
    }
  }
}

void draw() {
  if(frameCount % 60 == 0) println(frameRate);
  
  // Update
  
  if(mousePressed && mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height) particles[mouseX/particleSize][mouseY/particleSize].energy = 10;
  
  float[][] newEnergies = new float[particles.length][];
  
  for(int i = 0; i < particles.length; i++) {
    newEnergies[i] = new float[particles[i].length];
    for(int j = 0; j < particles[i].length; j++) {
      float energy = 0;
      
      boolean onLeft = i == 0;
      boolean onRight = i == particles.length - 1;
      boolean onTop = j == 0;
      boolean onBottom = j == particles[i].length - 1;
      
      energy += particles[i][j].energy;
      if(!onTop) energy += particles[i][j-1].energy;
      if(!onBottom) energy += particles[i][j+1].energy;
      
      if(!onLeft) energy += particles[i-1][j].energy;
      if(!onLeft && !onTop) energy += particles[i-1][j-1].energy;
      if(!onLeft && !onBottom) energy += particles[i-1][j+1].energy;
      
      if(!onRight) energy += particles[i+1][j].energy;
      if(!onRight && !onTop) energy += particles[i+1][j-1].energy;
      if(!onRight && !onBottom) energy += particles[i+1][j+1].energy;
      
      energy /= 9;
      
      newEnergies[i][j] = energy;
    }
  }
  
  // Render
  
  background(255);
  
  fill(255);
  stroke(0);
  ellipseMode(CENTER);
  
  for(int i = 0; i < particles.length; i++) {
    for(int j = 0; j < particles[i].length; j++) {
      particles[i][j].energy = newEnergies[i][j] * damp; 
      
      Particle p = particles[i][j];
      fill(lerpColor(noPressure, highPressure, p.energy));
      ellipse(p.position.x, p.position.y, particleSize / 2, particleSize / 2);
    }
  }
}
