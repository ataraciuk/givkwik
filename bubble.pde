class Bubble {
  public PGraphics canvas;
  public PImage image;
  public float xoff;
  public float initialX;
  public float y = 650;
  public float speed = random(0.5,1.5);
  
  public Bubble(PGraphics canv, PImage img, float iniX, float initOff) {
    canvas = canv;
    image = img;
    initialX = iniX;
    xoff = initOff;
  }
  
  public void moveAndDraw() {
    xoff = xoff + .01;
    y -= speed;
    y = max(y,0);
    float x = noise(xoff) * width/4;
    canvas.image(image, x+initialX, y);
  }
}
