class Building {
  float centerX, buildingWidth, buildingHeight, depth;
  
  Building(float centerX, float width, float height, float depth) {
    this.centerX = centerX;
    this.buildingWidth = width;
    this.buildingHeight = height;
    this.depth = depth;
  }
  
  void Render() {
    float actualWidth = this.buildingWidth / depth;
    float actualHeight = this.buildingHeight / depth;
    
    float centerY = height - actualHeight / 2;
    
    stroke(10);
    fill(30);
    
    rectMode(CENTER);
    
    rect(centerX, centerY, actualWidth, actualHeight);
  }
}
