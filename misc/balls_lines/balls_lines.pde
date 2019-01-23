ArrayList<Ball> balls;
void setup() {
  //size(800, 600);
  fullScreen();
  balls = new ArrayList<Ball>();
  
  for(int i = 0; i < 30; i++) {
    balls.add(new Ball());
  }
}

void draw() {
  background(112, 128, 144);
  
  ArrayList<Ball> tempBalls = new ArrayList<Ball>();
  
  for(Ball ball : balls) {
    ball.Update();
  
    ball.Render();
    
    for(Ball tempBall : tempBalls) {
      if(ball.position.dist(tempBall.position) < (ball.lineLength + tempBall.lineLength) / 2) {
        stroke(255, 150);
        line(ball.position.x, ball.position.y, tempBall.position.x, tempBall.position.y);
      }
    }
    
    tempBalls.add(ball);
  }
  
}
