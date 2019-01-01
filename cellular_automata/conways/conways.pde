/************
* Conway's game of life. Click to spawn a glider.
************/

ArrayList<Point> liveCells;

int drawScale = 8;

void setup() {
    fullScreen();

    liveCells = new ArrayList<Point>();

    // Blinker
    liveCells.add(new Point(29, 30));
    liveCells.add(new Point(30, 30));
    liveCells.add(new Point(31, 30));

    // Toad
    liveCells.add(new Point(50, 30));
    liveCells.add(new Point(51, 30));
    liveCells.add(new Point(52, 30));
    
    liveCells.add(new Point(51, 31));
    liveCells.add(new Point(52, 31));
    liveCells.add(new Point(53, 31));

    frameRate(10);
}

void draw() {
    background(255);
    
    scale(drawScale);

    Cells cells = new Cells();

    for(Point p : liveCells) {
        cells.SetAlive(p);
        cells.IncrementNeighbourCount(p.Add(1, 0), 1);
        cells.IncrementNeighbourCount(p.Add(-1, 0), 1);

        cells.IncrementNeighbourCount(p.Add(1, -1), 1);
        cells.IncrementNeighbourCount(p.Add(0, -1), 1);
        cells.IncrementNeighbourCount(p.Add(-1, -1), 1);

        cells.IncrementNeighbourCount(p.Add(1, 1), 1);
        cells.IncrementNeighbourCount(p.Add(0, 1), 1);
        cells.IncrementNeighbourCount(p.Add(-1, 1), 1);

        p.Draw();
    }

    liveCells.clear();

    for(Cell cell : cells.cells) {
        //println("Neighbours: " + cell.neighbours + ", Alive: " + cell.alive + ", " + cell.location);
        if((cell.neighbours == 2 && cell.alive) || cell.neighbours == 3) {
            liveCells.add(cell.location);
        }
    }

    //println("");
}

void mousePressed(){
    // Glider
    Point p = new Point(mouseX/drawScale, mouseY/drawScale);

    liveCells.add(p.Add(0, -1));
    liveCells.add(p.Add(1, 0));
    liveCells.add(p.Add(-1, 1));
    liveCells.add(p.Add(0, 1));
    liveCells.add(p.Add(1, 1));
}

class Point {
    int x, y;

    Point(int x, int y) {
        this.x = x;
        this.y = y;
    }

    // Non destructive addition of point
    Point Add(int x, int y) {
        return new Point(this.x + x, this.y + y);
    }

    Point Add(Point p) {
        return Add(p.x, p.y);
    }

    void Draw() {
        point(this.x, this.y);
    }

    public String toString() {
        return "(" + this.x + ", " + this.y + ")";
    }

    public boolean equals(Object o) {
        if(!(o instanceof Point)){
            return false;
        }

        Point p = (Point) o;
        return(p.x == this.x && p.y == this.y);
    }
}

class Cell {
    Point location;
    int neighbours = 0;
    boolean alive = false;

    Cell(Point location) {
        this.location = location;
    }

    Cell(Point location, int neighbours) {
        this(location);
        this.neighbours = neighbours;
    }
}

class Cells {
    ArrayList<Cell> cells;

    Cells() {
        cells = new ArrayList<Cell>();
    }

    // Adds a new cell
    Cell AddCell(Point location) {
        Cell c = new Cell(location);
        cells.add(c);
        return c;
    }

    // Increments the number of neighbours that a cell has
    void IncrementNeighbourCount(Point location, int increment) {
        for(Cell cell : cells) {
            if(cell.location.equals(location)) {
                cell.neighbours += increment;
                return;
            }
        }

        // No matching cell found, add a new one
        AddCell(location).neighbours = increment;
    }

    void SetAlive(Point location) {
        for(Cell cell : cells) {
            if(cell.location.equals(location)) {
                cell.alive = true;
                return;
            }
        }

        AddCell(location).alive = true;
    }
}