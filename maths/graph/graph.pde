ArrayList<Node> graph;
final int nodeSize = 20;
Node activeNode = null;

void setup() {
  size(1920, 1080);
  
  graph = new ArrayList<Node>();
}

void draw() {
  background(255);
  
  for(Node node : graph) {
    node.Draw();
  }
}

void mousePressed() {
  PVector mouse = new PVector(mouseX, mouseY);
  
  if(mouseButton == LEFT) {
    for(Node node : graph) {
      if(mouse.dist(node.location) < nodeSize) {
        if(activeNode == null) {
          node.active = true;
          activeNode = node;
        } else {
          activeNode.active = false;
          activeNode.connected.add(node);
          node.connected.add(activeNode);
          activeNode = null;
        }
        return;
      }
    }
    
    Node newNode = new Node(graph.size(), mouse);
    graph.add(newNode); 
    if(activeNode != null) {
      activeNode.active = false;
      activeNode.connected.add(newNode);
      newNode.connected.add(activeNode);
      activeNode = null;
    }
  }
}
