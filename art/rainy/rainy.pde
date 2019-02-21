ArrayList<RainDrop> rain;

void setup() {
  size(1920, 1080);
  
  rain = new ArrayList();
  frameRate(60);
}

void draw() {
  background(255);
  
  int size = rain.size();
  while(size < 1000 && rain.size() < size + 10) {
    rain.add(new RainDrop()); 
  }
  
  float xSpeed = sin(frameCount / 250.0) * 10;
  
  for(RainDrop drop : rain) {
    drop.velocity.x = xSpeed;
    drop.Update();
    
    if(drop.position.y >= height) {
      drop.Initialize();
    }
    drop.Draw();
  }
}
