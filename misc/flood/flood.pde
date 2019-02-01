State[][] grid;

int cellSize = 20;

int lastTick = 0;

void setup() {
  size(1920, 1080);
  
  grid = new State[width/cellSize][];
  
  for(int i = 0; i < grid.length; i++) {
    grid[i] = new State[height/cellSize];
    for(int j = 0; j < grid[i].length; j++) {
      setCell(i, j, State.Empty); 
    }
  }
  
  frameRate(24);
}

void draw() {
  if(millis() - lastTick > 1000) {
    lastTick = millis();
    
    for(int i = 0; i < grid.length; i++) {
      for(int j = 0; j < grid[i].length; j++) {
        switch(grid[i][j]) {
          case Water:
            if(i > 0 && grid[i - 1][j] == State.Empty) setCell(i - 1, j, State.Water); 
            if(i < grid.length - 1 && grid[i + 1][j] == State.Empty) setCell(i + 1, j, State.Wet); 
            if(j > 0 && grid[i][j - 1] == State.Empty) setCell(i, j - 1, State.Water); 
            if(j < grid[i].length - 1 && grid[i][j + 1] == State.Empty) setCell(i, j + 1, State.Wet); 
            break;
          case Wet:
            setCell(i, j, State.Water);
        }
      }
    }
  }
  
  if(mousePressed) {
    int x = mouseX / cellSize;
    int y = mouseY / cellSize;
    if(mouseButton == LEFT) {
      setCell(x, y, State.Blocked); 
    } else {
      setCell(x, y, State.Water); 
    }
  }
  
  for(int i = 0; i < grid.length; i++) {
    for(int j = 0; j < grid[i].length; j++) {
      switch(grid[i][j]) {
        case Empty:
          fill(255);
          break;
        case Wet:
        case Water:
          fill(0, 0, 255);
          break;
        case Blocked:
          fill(0);
          break;
      }
      
      rect(i * cellSize, j * cellSize, cellSize, cellSize);
    }
  }
}

void setCell(int x, int y, State state) {
  if(x < 0 || x > grid.length - 1|| y < 0 || y > grid[x].length - 1) return;
  grid[x][y] = state; 
}

void keyPressed() {
  setup(); 
}
