ArrayList<Node> graph;
final int nodeSize = 20;
Node activeNode = null;

ArrayList<Integer> path;

void setup() {
  size(1920, 1080);
  
  graph = new ArrayList<Node>();
}

void draw() {
  background(255);
  
  for(Node node : graph) {
    node.Draw();
  }
  
  if(path != null) {
    Node lastNode = null;
    stroke(255,0,0);
    strokeWeight(2);
    for(int id : path) {
      Node node = graph.get(id);
      if(lastNode != null) {
        line(lastNode.location.x, lastNode.location.y, node.location.x, node.location.y);
      }
      lastNode = node;
    }
  }
}

void mousePressed() {
  PVector mouse = new PVector(mouseX, mouseY);
  if(mouseButton == LEFT) {
    for(Node node : graph) {
      if(mouse.dist(node.location) < nodeSize) {
        if(activeNode == null) {
          node.state = Status.Create;
          activeNode = node;
        } else {
          activeNode.state = Status.Normal;
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
      activeNode.state = Status.Normal;
      activeNode.connected.add(newNode);
      newNode.connected.add(activeNode);
      activeNode = null;
    }
  } else {
    for(Node node : graph) {
      if(mouse.dist(node.location) < nodeSize) {
        if(activeNode == null) {
          node.state = Status.Path;
          activeNode = node;
        } else {
          // djikstra
          path = null;
          
          Node origin = activeNode;
          Node target = node;
          ArrayList<Integer> unvisited = new ArrayList<Integer>();
          for(Node n : graph) {
            unvisited.add(n.id); 
          }
          float[] distances = new float[unvisited.size()];
          int[] previousId = new int[unvisited.size()];
          for(int i = 0; i < unvisited.size(); i++) {
            distances[i] = (i == origin.id) ? 0 : Float.MAX_VALUE;
            previousId[i] = -1;
          }
          
          while(unvisited.contains(target.id)) {
            float lowestDistance = Float.MAX_VALUE;
            int lowestId = -1;
            for(int id : unvisited) {
              if(distances[id] < lowestDistance) {
                lowestDistance = distances[id];
                lowestId = id;
              }
            }
            
            if(lowestId == -1) {
              // no path, break
              break;
            } else {
              Node currentNode = graph.get(lowestId);
              for(Node neighbour : currentNode.connected) {
                float distanceToNode = lowestDistance + PVector.dist(currentNode.location, neighbour.location);
                if(distanceToNode < distances[neighbour.id]) {
                  distances[neighbour.id] = distanceToNode; 
                  previousId[neighbour.id] = currentNode.id;
                }
              }
              
              unvisited.remove(new Integer(lowestId));
            }
          }
          
          
          
          if(distances[target.id] != Float.MAX_VALUE) {
            // found a path;
            path = new ArrayList<Integer>();
            int currentId = target.id;
            while(currentId != -1) {
              path.add(currentId);
              currentId = previousId[currentId];
            }
          }
          
          activeNode.state = Status.Normal;
          activeNode = null;
        }
        return;
      }
    }
  }
}

void keyPressed() {
  path = null; 
}
