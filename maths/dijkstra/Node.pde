class Node {
  PVector location;
  int id;
  ArrayList<Node> connected;
  final int nodeSize = 20;
  Status state = Status.Normal;
  
  Node(int id, PVector loc) {
    this.id = id;
    location = loc;
    connected = new ArrayList<Node>();
  }
  
  void Draw() {
    
    // Draw circle for node
    ellipseMode(RADIUS);
    noFill();
    switch(state) {
      case Normal:
        stroke(0);
        break;
      case Create:
        stroke(0, 0, 255);
        break;
      case Path:
        stroke(255, 0, 0);
        break;
    }
    strokeWeight(1);
    ellipse(location.x, location.y, nodeSize, nodeSize);
    
    // Write node text
    fill(0);
    text(id, location.x - 5, location.y + 5);
    
    // Draw connections
    stroke(0);
    strokeWeight(1);
    for(Node connection : connected) {
      line(location.x, location.y, connection.location.x, connection.location.y); 
    }
  }
}

enum Status {
  Normal,
  Create,
  Path
}
