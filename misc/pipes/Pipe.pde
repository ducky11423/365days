class Pipe {
  PVector start;
  PVector end;
  
  boolean vertical;
  
  color colour;
  
  int children = 0;
  
  Pipe(PVector start, PVector end, boolean vertical) {
    this.start = start;
    this.end = end;
    this.vertical = vertical;
    
    colour = color(random(240, 300), random(50, 100), random(40, 60));
  }
}
