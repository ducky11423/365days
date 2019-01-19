class EdgeCollider {
  PVector start, end;
  
  EdgeCollider(){}
  
  EdgeCollider(PVector start, PVector end) {
    this.start = start;
    this.end = end;
    
  }
  
  void Render() {
    stroke(0, 255, 0);
    strokeWeight(4);
    line(start.x, start.y, end.x, end.y);
  }
}
