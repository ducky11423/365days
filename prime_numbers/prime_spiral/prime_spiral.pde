float theta = 0;
float revs = 1;
float gap = PI / 2;
int n = 0;
float pointsToDo = 1;
ArrayList<PVector> points;

float r = 0.2;

void setup() {
    size(1920, 1080);
    
    
    points = new ArrayList<PVector>();
    
    strokeWeight(2);
    frameRate(60);
}

void draw() {
  
  for(int i = 0; i < pointsToDo; i++) {
    if(theta >= revs * 2 * PI) {
      n = (int) (revs * revs);
      theta = 2 * revs * PI;
      float lastSquare = revs * revs;
      revs++;
      float nextSquare = revs * revs;
      pointsToDo = nextSquare - lastSquare;
      gap = (2 * PI) / pointsToDo;
    }
     
    if(isPrime(n)) points.add(new PVector(theta * r * cos(theta), theta * r * sin(theta)));
     
    theta += gap;
    n++;
  }
  
  background(255);
  translate(width/2, height/2);
  
  float scale = max(width, height) / r / (theta) / 4;
  scale(scale);
  
  for(PVector point : points) {
    point(point.x, point.y); 
  }
}

boolean isPrime(int n) {
  for(int i = 2; i < n; i++) {
    if(n % i == 0) return false; 
  }
  
  return true;
}
