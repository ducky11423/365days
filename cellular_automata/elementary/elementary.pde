/************
* Elementary cellular automata
************/

boolean[] rules;
int rule;
int y = 1;

void setup() {
    fullScreen();

    setRule(0);

    background(255);
    loadPixels();
    pixels[width/2] = 0;
    updatePixels();

    frameRate(600);
}

void setRule(int r) {
    println("Rule: " + r);
    rule = r;

    int n = rule;

    rules = new boolean[8];

    for(int i = 7; i >= 0; i--){
        rules[i] = (n/pow(2, i) >= 1);
        n %= pow(2, i);
    }
}

void draw() {
    if(rule == 256) {
        background(0);
        return;
    }
    if(y == height) {
        y = 1;
        setRule(rule + 1);
    }

    stroke(255);
    strokeWeight(1);
    line(0, y+1, width, y+1);

    loadPixels();

    for(int i = 0; i < width; i++) {
        int count = 0;
        for(int j = 0; j < 3; j++) {
            int x = i - j + 1;
            if(x < 0) x = width-1;
            else if(x == width) x = 0;
            count += (pixels[x + (y-1)*width] != -1) ? pow(2, j) : 0;

        }

        pixels[i + y*width] = (rules[count]) ? color(255, 0, 0) : color(255);
        
    }

    updatePixels();
    y++;
}