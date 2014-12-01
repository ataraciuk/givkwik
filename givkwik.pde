import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;
int timeToCheckAPI = 10000; //how much time has to pass before calling API again
int lastTime;
PFont f;
PImage bg;
PImage bg2;
ArrayList<Bubble> bubbles = new ArrayList<Bubble>();
PImage[] imgs;
int bubblesAddedToTest = 5; //change this to set minimum amount of bubbles, for testing reasons. in live event should be 0

JSONObject lastResult; //here we store the previous value, to compare next values

void setup() {
  noStroke();
  size(720, 1280,P2D);
  canvas = createGraphics(720, 1280,P2D);
  lastResult = loadJSONObject("https://givkwik.com/campaigns/givingTuesday-2014/results/json");
  server = new SyphonServer(this, "Processing Syphon");
  lastTime = millis();
  f = createFont("Arial",16,true);
  textFont(f,16);
  bg = loadImage("Background_01.png");
  bg2 = loadImage("Background_02.png");
  imgs = new PImage[]{loadImage("DollarSign_GreenCircle_Small.png"), loadImage("smiley_happy_orange_small.png")};
}

void draw() {
  int newTime = millis();
  if(newTime - lastTime > timeToCheckAPI) {
    lastTime = newTime;
    println("checking API");
    JSONObject newResult = loadJSONObject("https://givkwik.com/campaigns/givingTuesday-2014/results/json");
    int newVotes = newResult.getInt("totalVotes") - lastResult.getInt("totalVotes");
    int newDonations = newResult.getInt("totalDonations") - lastResult.getInt("totalDonations");
    for(int i = 0; i < newVotes+bubblesAddedToTest;i++) {
      bubbles.add(new Bubble(canvas, imgs[1], random(3*width/4), random(1)));
    }
    for(int i = 0; i < newDonations+bubblesAddedToTest;i++) {
      bubbles.add(new Bubble(canvas, imgs[0], random(3*width/4), random(1)));
    }
    lastResult = newResult;
  }
  canvas.beginDraw();
  canvas.background(255);
  canvas.stroke(0);
  canvas.fill(0);
  canvas.image(bg2, 0, 0);
  for(Bubble b : bubbles) {
    b.moveAndDraw();
  }
  canvas.image(bg, 0, 0);
  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
}
