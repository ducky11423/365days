class Node {
  PVector location;
  int id;
  ArrayList<Node> connected;
  final int nodeSize = 20;
  boolean active = false;
  
  Node(int id, PVector loc) {
    this.id = id;
    location = loc;
    connected = new ArrayList<Node>();
  }
  
  void Draw() {
    
    // Draw circle for node
    ellipseMode(RADIUS);
    noFill();
    if(active) stroke(0, 0, 255);
    else stroke(0);
    ellipse(location.x, location.y, nodeSize, nodeSize);
    
    // Write node text
    fill(0);
    text(id, location.x - 5, location.y + 5);
    
    // Draw connections
    stroke(0);
    for(Node connection : connected) {
      line(location.x, location.y, connection.location.x, connection.location.y); 
    }
  }
}
