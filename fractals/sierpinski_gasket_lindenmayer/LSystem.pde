class LSystem {
  String axiom;
  String production;
  StringDict rules;
  
  Boolean coloured = false;
  
  int generation = 1;
  
  LSystem(String axiom) {
     this.axiom = axiom;
     this.production = axiom;
     
     this.rules = new StringDict();
  }
  
  void reset() {
    production = axiom; 
  }
  
  void addRule(String predecessor, String successor) {
    rules.set(predecessor, successor);  
  }
  
  void iterate(){
    String workingProduction = "";
    
    for(int i = 0; i < production.length(); i++){
      String symbol = production.substring(i, i+1);
      
      if(rules.hasKey(symbol)) {
        workingProduction += rules.get(symbol);
      } else {
        workingProduction += symbol; 
      }
    }
    
    production = workingProduction;
    generation++;
  }
  
  void draw() {
    /*
    * Symbol meanings: 
    * + -> rotate clockwise
    * - -> rotate counterclock wise
    * F -> draw a line /and/ translate to the end of it
    * [ -> push translation/rotation to stack 
    * ] -> pop translation/rotation from stack
    *
    * any other symbol is simply ignored
    */
    
    int numDraws = 0;
  
    for(int i = 0; i < production.length(); i++){
      if(production.charAt(i) == 'F' || production.charAt(i) == 'G') numDraws++; 
    }
    
    int drawCount = 0;
    
    for(int i = 0; i < production.length(); i++){
      String symbol = str(production.charAt(i));
      stroke(0);
      
      switch(symbol) {
        case "+":
          rotate(2 * PI / 3);
          break;
        case "-":
          rotate(-2 * PI / 3);
          break;
        case "F":
        case "G":
          if(coloured) {
            colorMode(HSB, 1);
            stroke(norm(drawCount, 0, numDraws), 1, 1);
          }
          
          line(0, 0, 0,-10);
          translate(0, -10);
          colorMode(RGB, 255);
          
          drawCount++;
          break;
        case "[":
          pushMatrix();
          break;
        case "]":
          popMatrix();
          break;
        case "O":
          ellipseMode(CENTER);
          stroke(0, 0, 255);
          ellipse(0, 0, 5, 5);
      }
    }
  }
}
