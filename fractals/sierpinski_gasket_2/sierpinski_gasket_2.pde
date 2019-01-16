final float sqrt3 = sqrt(3);

PShape triangle;
float triangleRadius;

int animationPart = 0; // Used to cycle between what step of the animation we're on
int animationPartStart = 0; // The time that this animation part started at. Used for timing of scales and translations and such.

void setup() {
  size(1920, 1080);
  
  triangleRadius = height * 4 / 7.0;
  
  triangle = createShape();
  triangle.beginShape();
  triangle.noFill();
  
  for(int i = 1; i < 5; i++) {
     triangle.vertex(cos(2*(i+0.25)*PI/3)*triangleRadius, sin(2*(i+0.25)*PI/3)*triangleRadius);
  }
  triangle.endShape();
  
  noLoop();
}

void draw() {
  translate(width/2, triangleRadius * 1.125);
  
  int animPart = animationPart % 5;
  
  if(animPart != 4) background(255); 
  
  if(animPart == 0) {
    // Inital down scaling of triangle
    
    float animationTime = millis() - animationPartStart; // How long the animation has been going for
    float animationDuration = 2000;
    
    if(animationTime > animationDuration) {
      nextAnimationPart();
    }
    scale(map(animationTime, 0, animationDuration, 1, 0.5));
    shape(triangle);
  } else if(animPart == 1) {
     // Translation of triangle up
    float animationTime = millis() - animationPartStart; // How long the animation has been going for
    float animationDuration = 1000;
    
    if(animationTime > animationDuration) {
      nextAnimationPart();
    }
    
    translate(0, map(animationTime, 0, animationDuration, 0, -triangleRadius*0.5));
    scale(0.5);
    
    shape(triangle);
  } else if(animPart == 2) {
    float animationTime = millis() - animationPartStart; // How long the animation has been going for
    float animationDuration = 1000;
    
    if(animationTime > animationDuration) {
      nextAnimationPart();
    }
    
    pushMatrix();
    
    translate(0, -triangleRadius*0.5);
    scale(0.5);
    shape(triangle);
    
    popMatrix();
    
    translate(0, -triangleRadius*0.5);
    translate(map(animationTime, 0, animationDuration, 0, -sqrt3/4*triangleRadius), map(animationTime, 0, animationDuration, 0, triangleRadius*0.75));
    scale(0.5);
    shape(triangle);
    
  } else if(animPart == 3) {
    float animationTime = millis() - animationPartStart; // How long the animation has been going for
    float animationDuration = 1000;
    
    if(animationTime > animationDuration) {
      nextAnimationPart();    
    } 
    
    pushMatrix();
    
    translate(0, -triangleRadius*0.5);
    scale(0.5);
    shape(triangle);
    
    popMatrix();
    
    pushMatrix();
    
    translate(-sqrt3/4*triangleRadius, triangleRadius*0.25);
    scale(0.5);
    shape(triangle);
    
    popMatrix();
    
    translate(0, -triangleRadius*0.5);
    translate(map(animationTime, 0, animationDuration, 0, sqrt3/4*triangleRadius), map(animationTime, 0, animationDuration, 0, triangleRadius*0.75));
    scale(0.5);
    shape(triangle);
  } else if(animPart == 4 ) {
   
    // Change shape to be the composite shape. This is kinda tricky but oh well. Pretty much have to do all the transformations for the rendering but onto the shape?
      
    PShape newTriangle = createShape();
    newTriangle.beginShape();
    newTriangle.noFill();
    
    int nVertices = triangle.getVertexCount();
    
    float xTranslation, yTranslation;
    
    xTranslation = 0;
    yTranslation = -triangleRadius;
    
    
    for(int i = 0; i < nVertices; i++) {
      PVector vertex = triangle.getVertex(i);
      newTriangle.vertex((vertex.x + xTranslation)*0.5, (vertex.y + yTranslation+0.5)*0.5);
    }
    
    newTriangle.vertex(cos(2 * PI / 3) * triangleRadius * sqrt(3)/2, -sin(2 * PI / 3) * triangleRadius * sqrt(3)/6);
    
    xTranslation = -sqrt3/2*triangleRadius;
    yTranslation = triangleRadius * 0.5;
        
    for(int i = 0; i < nVertices; i++) {
      PVector vertex = triangle.getVertex(i);
      newTriangle.vertex((vertex.x + xTranslation) * 0.5, (vertex.y + yTranslation+0.5)*0.5);
    }
    
    newTriangle.vertex(0, triangleRadius/2);
    
    xTranslation = sqrt3/2*triangleRadius;
    yTranslation = triangleRadius * 0.5;
    
    for(int i = 0; i < nVertices; i++) {
      PVector vertex = triangle.getVertex(i);
      newTriangle.vertex((vertex.x + xTranslation) * 0.5, (vertex.y + yTranslation+0.5)*0.5);
    }
    
    newTriangle.endShape();
    
    triangle = newTriangle;  
    
    nextAnimationPart();
  }

}

void keyPressed() {
  loop(); 
  animationPartStart=millis();
}

void nextAnimationPart(){
  animationPart++;
  animationPartStart = millis();
}
