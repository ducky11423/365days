ArrayList<Pipe> pipes;

void setup() {
  size(1920, 1080);
  
  pipes = new ArrayList<Pipe>();
  
  colorMode(HSB, 360, 100, 100);
  
  pipes.add(new Pipe(new PVector(0, height/2), new PVector(width, height/2), false));
}


void draw() {
  background(0);
  
  // add new pipe 
  int random = (int) random(pipes.size());
  
  if(pipes.get(random).children < 3) {
    
    Pipe pipe = pipes.get(random);
    
    pipe.children++;
  
    PVector start = PVector.lerp(pipe.start, pipe.end, random(0.6) + 0.2);
    PVector end = start.copy();
    
    float length = (random(200) + 100) * (random(1) < 0.5 ? 1 : -1);
    
    if(pipe.vertical) {
      end.x += length;
    } else {
      end.y += length; 
    }
    
    pipes.add(new Pipe(start, end, !pipe.vertical));
  }  
  
  for(Pipe pipe : pipes) {
    stroke(pipe.colour);
    strokeWeight(8);
    
    line(pipe.start.x, pipe.start.y, pipe.end.x, pipe.end.y); 
  }
  
  filter(BLUR, 6);
  
  for(Pipe pipe : pipes) {
    stroke(pipe.colour);
    strokeWeight(4);
    
    line(pipe.start.x, pipe.start.y, pipe.end.x, pipe.end.y); 
  }
}
