ArrayList<Building> buildings;

void setup() {
  size(1920, 1080);
  
  buildings = new ArrayList<Building>();
  
  float currentX = 0;
  
  boolean[] taken = new boolean[width / 20];
  for(int i = 0; i < taken.length; i++) taken[i] = false;
  
  for(int i = 0; i < 50; i++) {
    float centerX = random(0, width);
    
    if(taken[(int)centerX / 20]) continue;
    
    float buildingWidth = 200;
    float buildingHeight = random(500, 800);
    float depth = random(1, 2);
    
    buildings.add(new Building(centerX, buildingWidth, buildingHeight, depth));
    
    taken[(int)centerX / 20] = true;
  }
  
  noLoop();
}

void draw() {
  background(60, 56, 61);
  
  for(Building building : buildings) {
    building.Render();
  }
}
