IntList sequence;
float scale = 50;
float progress = 0;

void setup() {
    fullScreen(1);
    
    sequence = new IntList();
    sequence.append(0);
    incrementSequence();
    frameRate(60);
}

void draw() {
  background(255);
  
  translate(0, height/2);
  scale(scale);
  
  noFill();
  stroke(0);
  strokeWeight(1 / scale);
  
  int lastValue = -1;
  int loops = 0;
  boolean even = false;

  for(int i : sequence) {
    if(lastValue != -1) {
      float center = (lastValue + i) / 2.0;
      int circleWidth = abs(lastValue - i);
      
      float angle = PI * (loops == sequence.size() - 1 ? progress : 1);
      
      if(even) {
        if(i < lastValue) arc(center, 0, circleWidth, circleWidth, 0, angle); 
        else arc(center, 0, circleWidth, circleWidth, PI - angle, PI); 
      } else {
        if(i < lastValue) arc(center, 0, circleWidth, circleWidth, 2 * PI - angle, 2 * PI);
        else arc(center, 0, circleWidth, circleWidth, PI, PI + angle); 
      }
    }

    lastValue = i;
    even = !even;
    loops++;
  }

  if(progress >= 1) {
    incrementSequence();
    progress = 0;
  } else progress += 0.2;
  
  if(sequence.max() > (width - 40) / scale) scale /= 1.02;
}

void incrementSequence() {
  int currentTerm = sequence.get(sequence.size() - 1);
  int step = sequence.size();
  if(currentTerm <= step || sequence.hasValue(currentTerm - step)) {
    sequence.append(currentTerm + step); 
  } else sequence.append(currentTerm - step);
}
