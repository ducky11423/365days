LSystem lsystem;  

void setup(){
  size(1920, 1080);
  
  lsystem = new LSystem("F-G-G");
  lsystem.addRule("F", "F-G+F+G-F");
  lsystem.addRule("G", "GG");
  
  lsystem.coloured = true;
  
  frameRate(1);
}

void draw() {
  background(255);
  
  float scaleAmount = width / 10 / pow(2, lsystem.generation); // this works fine on 16:9 displays, but on some displays the triangle might float off the edge
  
  translate(width/2,height/2 + 60);
  translate(pow(2,lsystem.generation) * -2.5 * scaleAmount, pow(2,lsystem.generation) * 2.5 * scaleAmount / sqrt(3));
  rotate(PI/2);
  scale(scaleAmount);
  
  lsystem.draw();
  lsystem.iterate();
}
