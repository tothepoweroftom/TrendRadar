//GUI LEFT SIDE TEXT
class TextDisplayLeft {

  int x, y, w, h;
  float spacing, xspacing;
  color normal = color(230);
  color highlight = color(255);
  int normalSize = 20;
  int highlightSize = 28;

  TextDisplayLeft(int x, int y, int w, int h, float spacing) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.spacing = spacing;
    this.xspacing = spacing/2;
  }


  void display() {
    pushMatrix();
    pushStyle();
    textFont(font, 22);

    //FILTER TEXT
    fill(100);
    textFont(font, highlightSize);
    textAlign(LEFT, BOTTOM);
    text("filter", width/64, (height/36)*2);
    fill(255);
    text("" + keywords[0], (width/64)*5, (height/36)*2);
    //fill(normal+10);
    //textFont(font2, normalSize);
    //text(keywords[0], x  + xspacing, y+spacing, w, h);

    //No. Tweets
    fill(100);
    textFont(font, 22);
    text(".tweets", width/64, ((height/36)*22), w, h);
    fill(255);
    textFont(font2, normalSize);
    text("|" + str(tweetCount), width/64, ((height/36)*23), w, h);

    //No. Hashtags
    fill(100);
    textFont(font, 22);
    text(".hashtags", width/64, ((height/36)*25), w, h);
    fill(255);
    textFont(font2, normalSize);
    text("|" + str(hashCount), width/64, ((height/36)*26), w, h);


    fill(100);
    textFont(font, 22);
    text(".happiness%", width/64, ((height/36)*28), w, h);
    fill(255);
    textFont(font2, normalSize);
    text("|" + str(avgsentiment), width/64, ((height/36)*29), w, h);
    textFont(font, 16);

    textAlign(RIGHT, TOP);
    text(myIP+"", width-(width/64), height/36);

    popStyle();
    popMatrix();
  }
}

class TextDisplayRight {
  int x, y, w, h;
  float spacing, xspacing;
  color normal = color(230);
  color highlight = color(255);
  int normalSize = 20;
  int highlightSize = 26;

  String tweet="You Can't Keep Boogieing Like This. You'll Come Down With A Fever Of Some Sort.";
  String user="Turanga Leela";
  String location="New New York";
  PImage userImage=loadImage("leela.png");
  Boolean mode = false;

  TextDisplayRight(int x, int y, int w, int h, int spacing) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.spacing = spacing;
    this.mode = false;
  }


  void display() {
    if (mode == true) {
      //this.clearData();
    } else if ( mode == false) {
      displayTweetInfo();
      displayHashtagInfo();
    }
    noStroke();
    fill(0, 20);
    rect(x, 0, w, height);
  }

  void displayTweetInfo() {
    pushMatrix();
    pushStyle();
    textFont(font, highlightSize);
    fill(highlight-5);
    //text("User: " + this.user, x, y, w, h);
    textAlign(CENTER, CENTER);
    text("" + this.user, (width/64)*57, ((height/36)*24)+w*0.35);
    //textSize(normalSize);
    fill(normal);
    if (this.location != null) {
      textSize(16);
      text("" + this.location, (width/64)*57, ((height/36)*24)+w*0.45);
    }

    if (userImage != null) {
      //imageMode(C);
      this.userImage.filter(GRAY);
      //image(userImage, x+w*0.25, y+4*spacing, w*0.5, w*0.5);

      pushMatrix();
      translate((width/64)*57, (height/36)*24);
      textureMode(NORMAL);
      beginShape();
      noFill();
      stroke(255, 100, 0);
      texture(userImage);
      for (int i = 0; i < 32; i++) {
        float stepFac = 2*PI*(float(i)/32); 
        vertex((w*0.25)*sin(stepFac), (w*0.25)*cos(stepFac), (sin(stepFac)+1)/2, (cos(stepFac)+1)/2);
      }
      endShape(CLOSE);
      popMatrix();
    }

    if (frameCount%2 == 0) {
      //pushMatrix();
      //translate(-w*0.5, 0);
      for (float x = -w*0.5; x < w*0.5; x += 4) {
        stroke(255, 100);
        line(x + (width/64)*57, ((height/36)*24)+w*0.52, x + (width/64)*57, ((height/36)*24)+w*0.55);
      }
      //popMatrix();
    }

    //TWEET INFO
    textFont(font2, normalSize-5);
    textAlign(CENTER);
    text(tweet, ((width/64)*57)-w*0.5, ((height/36)*24)+w*0.6, w, h*2);
    popStyle();
    popMatrix();
  }

  void displayHashtagInfo() {
    pushStyle();
    textFont(font, highlightSize);
    fill(highlight);
    text(selectedHashtag, x, 20, w, h);
    textSize(normalSize+10);
    fill(normal);
    text("Tweets: ", x, 20+spacing, w, h);
    //TWEET INFO
    textFont(font2, normalSize-5);

    for (int i=0; i<hashtagTweets.size(); i++) {
      if (i<2) {
        text(hashtagTweets.get(i), x, 20+(2)*spacing + i*h*0.7, w, h*2);
      }
    }
    popStyle();
  }

  void setTweet(String tweet) {
    this.tweet = tweet;
  }
  void setUser(String user) {
    this.user = user;
  }
  void setLocation(String location) {
    this.location = location;
  }
  void setImage(PImage image) {
    this.userImage = image;
  }
  void setData(String tweet, String user, String location, PImage image) {
    this.tweet = tweet;
    this.user = user;
    this.location = location;
    this.userImage = image;
  }

  void clearData() {
    this.tweet = "";
    this.user = "";
    this.location = "";
    this.userImage = null;
  }
}