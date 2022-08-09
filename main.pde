class CircleBuilder;

class Circle {
  private static ArrayList<Cicle> circles;
  private float x, y, dx, dy, ddx, ddy, size, mass;
  private color c;
  
  public Circle (float x, float y) {
    this(x, y, 0, 0, 0, 0, 10, 1, color(0));
  }
  
  public Circle (float x, float y, float dx, float dy, float ddx, float ddy, float d, float m, color c) {
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dx;
    this.ddx = ddx;
    this.ddy = ddy;
    this.d = d;
    Circle.register(this);
  }
  
  private static void register(Circle instance) {
    if (circles != null) {
      circles.add(instance);
    } else {
      circles = new ArrayList();
    }
  }
  
  private void update() {
    dx += ddx;
    dy += ddy;
    x += dx;
    y += dy;
    
    if (x + dx + ddx > width || x + dx + ddx < 0) {
      dx = -dx;
      ddx = -ddx;
    }
    
    if (y + dy + ddy > height || y + dy + ddy < 0) {
      dy = -dy;
      ddy = -ddy;
    }
    
    dx = signum(dx) * constrain(abs(dx - m * 0.01), 0, infinity);
    dy = signum(dy) * constrain(abs(dy - m * 0.01), 0, infinity);
    
    ddx = signum(ddx) * constrain(abs(ddx - m*m * 0.01), 0, infinity);
    ddy = signum(ddy) * constrain(abs(ddy - m*m * 0.01), 0, infinity);
  }
  
  private void render() {
    fill(c);
    circle(this.x, this.y, this.size);
  }
  
  public static void updateAll() {
    if (circles != null) {
      for (Circle circle : circles) 
        circle.update();
    }
  }
  
  public static void renderAll() {
    if (circles != null) {
      for (Circle circle : circles) 
        circle.render();
    }
  }
}

void setup () {
  fullScreen();
}

void loop() {
  updateAll();
  renderAll();
}

void mouseClicked() {
  new Circle (
    mouseX, 
    mouseY, 
    noise(frameCount)*2, 
    noise(frameCount)*2, 
    5, 
    5, 
    10, 
    1, 
    color(0)
  );
}


public int signum(float f) {
  if (f > 0) return 1;
  if (f < 0) return -1;
  return 0;
} 
