// ░░░░░░▄██████████████▄░░░░░░░
// ░░░░▄██████████████████▄░░░░░
// ░░░█▀░░░░░░░░░░░▀▀███████░░░░
// ░░█▌░░░░░░░░░░░░░░░▀██████░░░
// ░█▌░░░░░░░░░░░░░░░░███████▌░░
// ░█░░░░░░░░░░░░░░░░░████████░░
// ▐▌░░░░░░░░░░░░░░░░░▀██████▌░░
// ░▌▄███▌░░░░▀████▄░░░░▀████▌░░
// ▐▀▀▄█▄░▌░░░▄██▄▄▄▀░░░░████▄▄░
// ▐░▀░░═▐░░░░░░══░░▀░░░░▐▀░▄▀▌▌
// ▐░░░░░▌░░░░░░░░░░░░░░░▀░▀░░▌▌
// ▐░░░▄▀░░░▀░▌░░░░░░░░░░░░▌█░▌▌
// ░▌░░▀▀▄▄▀▀▄▌▌░░░░░░░░░░▐░▀▐▐░
// ░▌░░▌░▄▄▄▄░░░▌░░░░░░░░▐░░▀▐░░
// ░█░▐▄██████▄░▐░░░░░░░░█▀▄▄▀░░
// ░▐░▌▌░░░░░░▀▀▄▐░░░░░░█▌░░░░░░
// ░░█░░▄▀▀▀▀▄░▄═╝▄░░░▄▀░▌░░░░░░
// ░░░▌▐░░░░░░▌░▀▀░░▄▀░░▐░░░░░░░
// ░░░▀▄░░░░░░░░░▄▀▀░░░░█░░░░░░░
// ░░░▄█▄▄▄▄▄▄▄▀▀░░░░░░░▌▌░░░░░░
// ░░▄▀▌▀▌░░░░░░░░░░░░░▄▀▀▄░░░░░
// ▄▀░░▌░▀▄░░░░░░░░░░▄▀░░▌░▀▄░░░
// ░░░░▌█▄▄▀▄░░░░░░▄▀░░░░▌░░░▌▄▄
// ░░░▄▐██████▄▄░▄▀░░▄▄▄▄▌░░░░▄░
// ░░▄▌████████▄▄▄███████▌░░░░░▄
// ░▄▀░██████████████████▌▀▄░░░░
// ▀░░░█████▀▀░░░▀███████░░░▀▄░░
// ░░░░▐█▀░░░▐░░░░░▀████▌░░░░▀▄░
// ░░░░░░▌░░░▐░░░░▐░░▀▀█░░░░░░░▀
// ░░░░░░▐░░░░▌░░░▐░░░░░▌░░░░░░░
// ░╔╗║░╔═╗░═╦═░░░░░╔╗░░╔═╗░╦═╗░
// ░║║║░║░║░░║░░░░░░╠╩╗░╠═╣░║░║░
// ░║╚╝░╚═╝░░║░░░░░░╚═╝░║░║░╩═╝░
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/*
** What you should merge
 **
 ** Replace entire HashtagNode class with the one included in this sketch
 ** Replace dataFetching method with backg() method (you have to change the function call in the draw function as well)
 ** Replace resetGraph function, I added a counter and I don't remember what else I changed, so it should be better to replace it (or at least check what is different)
 **
 ** You can find the rest by searching "EDITED" with the search tool.
 ** For anything ask me :D
 **
 ** Cheers
 **
 */

import generativedesign.*;
import processing.data.XML;
import processing.pdf.*;
import java.net.*;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.io.*;
import java.net.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.concurrent.ConcurrentHashMap;
import java.util.Map;
import controlP5.*;
import processing.data.*;

import org.processing.wiki.triangulate.*;

//Spacebrew - Implementation
import spacebrew.*;
String server="localhost";
String name="TwitterApp1";
String description ="Twitter data visualization";


Spacebrew sb;
PVector slider;

//Global control values
int slider1 = 180;
int slider2 = 180;
int linearSlider = 0;
boolean centerButton = false;
String filter = "technology";
boolean circularSliderActive= false;
boolean XYActive = false;

PApplet root = this;

ControlP5 cp5;
Textfield txtfld; // EDITED
String textValue = "";

TwitterGraph myTwitterGraph;
float nodeDiameter = 25;

//Global node reference
MainNode global;

//Default keyword array
String keywords[] = {
  "sport"
};  
String hashtags[];

public PVector interaction = new PVector(0, 0);

StringList globalTweets = new StringList();



int CANVAS_WIDTH = 1280;
float zoom = 0.2;

//TEXT GUI
TextDisplayLeft tl;
TextDisplayRight tr;
//Global data for hashtags
StringList hashtagTweets = new StringList();
Boolean hashtagMode = false;
String selectedHashtag = "";

int fadeOutTime = 100000;


//Global Counters
int hashCount = 0;
int tweetCount =0;

//To attach springs
Node dummyCenterNode;


//Twitter drawing code;

//DRAWING CODE
int clr [] = {255, 0};
int min = 5, max = 18;
int limit = 180;
PFont font;
PFont font2;

float c = 1;
String[] symmb;
boolean twitFlag = false;
PImage userImage;
String userImageURL;
PImage maskImage;

//Internet stuff
TwitterStream twitterStream;

//Sentiment Analysis
HttpURLConnection conn = null;
StringBuilder response = new StringBuilder();
processing.data.JSONObject ezm = new processing.data.JSONObject();

/*
** 
 ** EDITED
 ** Modified ArrayList with ConcurrentHashmap with Integers as identifiers and HashtagNodes as Objects
 ** Change "thcnodes" ArrayList line with "thcnodes" ConcurrentHashmap 
 **
 */

// Initialize ConcurrentHashMap for hashtag nodes
ConcurrentHashMap<Integer, HashtagNode> thcnodes = new ConcurrentHashMap<Integer, HashtagNode>();
int thcnodesnumber = 0;
ArrayList<HashtagNode> closestNodes = new ArrayList<HashtagNode>();
boolean resetNodes = false;

color averageSentiment;
ArrayList<Color> averageColor = new ArrayList<Color>();
ArrayList<MainNode> selectedNodes = new ArrayList<MainNode>();
ArrayList<Integer> avg = new ArrayList<Integer>();
int avgsentiment = 0;

Boolean thcClicked = false;

static class Util {
  public static String streamToString(InputStream is) throws IOException {
    StringBuilder sb = new StringBuilder();
    BufferedReader rd = new BufferedReader(new InputStreamReader(is));
    String line;
    while ((line = rd.readLine()) != null) {
      sb.append(line);
    }
    return sb.toString();
  }
}


//IP ADDRESS
import java.net.InetAddress;
InetAddress inet;
String myIP;

Boolean toggleText = true;
float dataX=0, dataY=0;



PApplet thisPApplet = this;

void settings() {
  fullScreen(P3D);
  //  size(1280, 720, P3D);
}

void setup() {
  //fullScreen(P3D);

  background(255);
  smooth();
  noStroke();
  dummyCenterNode = new Node(0, 0);
  myTwitterGraph = new TwitterGraph();
  maskImage = loadImage("mask.jpg");
  //Global array for storage - probably unnecessarily big
  symmb = new String[180];
  hashtags = new String[100];

  tl = new TextDisplayLeft(20, height/3, width/8, 50, 40);
  tr = new TextDisplayRight(width-width/6, height/4, width/8, 200, 40);

  /*
  ** EDITED
   **
   ** Changed fonts
   **
   */

  //font = createFont("blanch_condensed.ttf", 22);
  //font2 = createFont("futura.ttc", 22);

  //font = loadFont("BitstreamVeraSansMono-Roman-22.vlw");
  font = loadFont("Hack-Regular-22.vlw");
  //font = loadFont("SourceCodePro-Regular-22.vlw");
  //font2 = loadFont("OpenSans-48.vlw");
  font2 = loadFont("SourceCodePro-Regular-22.vlw");

  //font = loadFont("SourceCodePro-Light-22.vlw");

  //Begin Streaming from twitter
  openTwitterStream();
  //  URL url = null;


  //Add controls
  cp5 = new ControlP5(this);

  //txtfld = cp5.addTextfield("input")
  //  .setPosition(20, 20)
  //  .setSize(200, 40)
  //  .setFont(font)
  //  .setFocus(true)
  //  .setColorBackground(color(0))
  //  .setColor(color(255))
  //  //.setLabel("Filter:   " + keywords[0])
  //  .setLabel("Filter:   " + keywords[0])
  //  ;


  //Spacebrew setup
  // instantiate the spacebrewConnection variable
  sb = new Spacebrew( this );
  slider = new PVector(0, 0);
  // declare your publishers
  //sb.addPublish( "local_slider", "range", slider1 ); 

  // declare your subscribers
  sb.addSubscribe( "circularSlider", "range" );
  sb.addSubscribe( "XData", "range" );
  sb.addSubscribe( "YData", "range" );
  sb.addSubscribe( "refreshButton", "boolean" );
  sb.addSubscribe( "circularSliderActive", "boolean" );
  sb.addSubscribe( "XYActive", "boolean" );
  sb.addSubscribe( "filter", "string" );
  sb.addSubscribe( "toggle", "boolean" );

  sb.connect(server, name, description );


  //Print IP
  try {
    inet = InetAddress.getLocalHost();
    myIP = inet.getHostAddress();
  }
  catch (Exception e) {
    e.printStackTrace();
    myIP = "couldnt get IP";
  }
}


void draw() {
  background(0);

  backg();

  averagingColor();

  textFont(font, 30);

  // ------ update and draw graph ------
  myTwitterGraph.update();
  myTwitterGraph.draw();

  /* EDITED
   **
   ** Change the for loop with the new Iterator loop for the ConcurrentHashMap
   **
   */

  Iterator iter = thcnodes.entrySet().iterator();
  float a = atan2(mouseY-height/2, mouseX-width/2);
  int angle = int(degrees(a));
  while (iter.hasNext()) {
    Map.Entry me = (Map.Entry) iter.next();

    HashtagNode thc = (HashtagNode) me.getValue();

    thc.applyBehaviors(thcnodes);
    thc.update();
    thc.display();

    //println("angle: " + thc.getAngle());


    if (toggleText) {
      thc.textDisplay = true;
    } else {
      thc.textDisplay = false;
    }

    //if (circularSliderActive) {
    //Outer Slider Selector
    if (abs(thc.getAngle() - angle) < 10) {
      //  if (abs(thc.getAngle() - angle) < 5) {
      thc.isHighlighted = true;
      hashtagTweets = thc.tweetTexts;

      //println(slider1);
      closestNodes.add(thc);
      if (thcClicked) {
        thc.isClicked = true;
      }
    } else {
      thc.isHighlighted = false;
      //hashtagTweets.clear();
    }

    PVector txtpv = new PVector(width/2, height/2);
    if (thc.location.dist(txtpv) < 4) {
      resetNodes = true;
      keywords[0] = "#" + thc.theHashtag;
      background(255);
    }

    if (resetNodes) {
      thcnodes.clear();
      ////myTwitterGraph = new TwitterGraph();
      //myTwitterGraph.removeNodes();
      //resetNodes = false;
      //Clears Hashtags
      thcnodes.clear();

      //Clears tweets
      myTwitterGraph.removeNodes();
      //background(255);

      twitterStream.clearListeners();
      FilterQuery filtered = new FilterQuery();
      filtered.track(keywords);
      twitterStream.addListener(listener);

      if (keywords.length==0) {
        // sample() method internally creates a thread which manipulates TwitterStream 
        twitterStream.sample(); // and calls these adequate listener methods continuously.
      } else { 
        twitterStream.filter(filtered);
      }
      resetNodes = false;
    }

    if (closestNodes.isEmpty() ==false) {
      findClosestNode();
    }
    //}
    //}

    /*
  ** END OF EDITING
     **
     */

    if (toggleText) {
      if (symmb.length != 0) {
        drawText();
      }
    } else {
    }
  }
}

void findClosestNode() {
  //Check list of closest node for the closest then empty.
  int index = 0;
  for (HashtagNode node : closestNodes) {
    int min=10;
    if (node.getAngle()<min) {
      min = node.getAngle();
      index = closestNodes.indexOf(node); // get the index nr of the node
      //println("Index: " + index);
    }
  }
  closestNodes.get(index).isHighlighted = true; 
  closestNodes.clear();
}


//Keyboard controls
void keyPressed() {

  if (keyCode == UP) zoom *= 1.05;
  if (keyCode == DOWN) zoom /= 1.05;
  zoom = constrain(zoom, 0.05, 1);

  if (keyCode == RIGHT) myTwitterGraph.nodeSelector++;
  if (keyCode == LEFT) myTwitterGraph.nodeSelector--;


  if (key == 't' || key == 'T') {
    twitFlag = !twitFlag;
  }

  if (key == 'c' || key == 'C') {
    myTwitterGraph.removeNodes();
    hashCount = 0;
    tweetCount = 0;
  }

  if (key == 'l' || key == 'L') {
    myTwitterGraph.displayLabels();
  }
}

/*
** EDITED
 **
 ** Change the drawText function with this new one, some small improvements
 ** Like "screen-adaptive" fix
 **
 */

void drawText() {
  tl.display();
  tr.display();
}


// Stream it
void openTwitterStream() {  

  ConfigurationBuilder cb = new ConfigurationBuilder();  
  cb.setOAuthConsumerKey("E4uwmX20zgaCdsXsYd4esRzSc");
  cb.setOAuthConsumerSecret("q6bw1Wv9bM8Sy9ESLBtrHBe5V5jWS67efVIGNFPAmK8rrGtU6b");
  cb.setOAuthAccessToken("3569010795-G0rgegHwtXE5MksJzHavWb24GAWy2rneuHFZjDb");
  cb.setOAuthAccessTokenSecret("HZOIfhxvsrLUFZ86kOmzLoNg983lOkUOx3r9oHXNKbkkH");

  twitterStream = new TwitterStreamFactory(cb.build()).getInstance();

  FilterQuery filtered = new FilterQuery();



  filtered.track(keywords);
  //filtered.language("English");

  twitterStream.addListener(listener);

  if (keywords.length==0) {
    // sample() method internally creates a thread which manipulates TwitterStream 
    twitterStream.sample(); // and calls these adequate listener methods continuously.
  } else { 
    twitterStream.filter(filtered);
  }
  println("connected");
} 


// Implementing StatusListener interface
StatusListener listener = new StatusListener() {

  //@Override
  public void onStatus(Status status) {
    //System.out.println("@" + status.getUser().getScreenName() + " - " + status.getText());

    //Access tweet and user
    String name = status.getUser().getScreenName();
    String text = status.getText();

    userImageURL = status.getUser().getOriginalProfileImageURL();
    userImage = loadImage(userImageURL);

    //Number of followers
    int followers = status.getUser().getFollowersCount()*10;

    //Add a new tweet node, temporarily storing it in the global node
    global =(MainNode) myTwitterGraph.addNode(name, random(-7, 7), random(-7, 7));
    global.fadeCounter = followers;
    global.setText(text);
    //println("f: " + followers + " | g: " + global.fadeCounter);
    parseHashtag(followers, text, global);

    //println(myTwitterGraph.springs.size());

    String location = status.getUser().getLocation();
    //println(tzone);
    tweetCount++;

    tr.setData(text, name, location, userImage);

    //Temporarily store the data for global access
    if (symmb != null) {
      symmb[0] = text;
      symmb[1] = name;
      symmb[2] = location;
      twitFlag = true;
    }

    //Access sentiment server - assign color based on sentiment
    Tweet newTweet = new Tweet(name, text);
    color sentiment = newTweet.getColor();
    //averageSentiment = lerpColor(averageSentiment, sentiment, 0.5);
    averageColor.add(new Color(sentiment));
    avg.add(new Integer(newTweet.percentageSentiment));
    global.ranCol = sentiment;
  }

  //@Override
  public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
    System.out.println("Got a status deletion notice id:" + statusDeletionNotice.getStatusId());
  }

  //@Override
  public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
    System.out.println("Got track limitation notice:" + numberOfLimitedStatuses);
  }

  //@Override
  public void onScrubGeo(long userId, long upToStatusId) {
    System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
  }

  //@Override
  public void onStallWarning(StallWarning warning) {
    System.out.println("Got stall warning:" + warning);
  }

  //@Override
  public void onException(Exception ex) {
    ex.printStackTrace();
  }
};

//Shut the stream when done
void stop() {
  twitterStream.shutdown();
}


////Take input from the textfield
//public void input(String theText) {
//  // automatically receives results from controller input
//  println("a textfield event for controller 'input' : "+theText);
//  keywords[0]=theText;
//  openTwitterStream();
//  myTwitterGraph.removeNodes();
//  txtfld.setLabel("Filter:   " + keywords[0]);
//}


//Parse the tweet to extract the hashtags.
void parseHashtag(float lf, String tweetText, Node callingNode) {
  String patternStr = "(?:\\s|\\A)[##]+([A-Za-z0-9-_]+)";
  Pattern pattern = Pattern.compile(patternStr);
  Matcher matcher = pattern.matcher(tweetText);
  String result = "";

  // Search for Hashtags
  while (matcher.find()) {
    result = matcher.group();
    result = result.replace(" ", "");
    String search = result.replace("#", "");
    // println(search);
    //Add hashtag node to circle

    // EDITED
    boolean addHashtag = true;
    boolean looksArraylist = true;

    Iterator iter = thcnodes.entrySet().iterator();

    while (iter.hasNext()) {
      Map.Entry me = (Map.Entry) iter.next();

      HashtagNode thc = (HashtagNode) me.getValue();

      if (looksArraylist) {
        if (search.equals(thc.theHashtag)) {
          thc.nDiameter += 10;
          thc.addTweetText(tweetText);
          thc.numConnections++;
          //looksArraylist = false;
          addHashtag = false;
        }
        if (thc.life<50) {
          thcnodes.remove(thcnodesnumber);
          thcnodesnumber--;
        }
      }
    }

    if (addHashtag) {
      float a = random(TWO_PI);
      PVector p = new PVector(width/2 + (cos(a)*300), height/2 + (sin(a)*300));
      HashtagNode h = new HashtagNode(p, lf, search.toLowerCase(), tweetText);
      thcnodes.put(thcnodesnumber, h);
      thcnodesnumber++;
      //thcnodes.add(h);
    }

    //MainNode node =(MainNode) myTwitterGraph.addHashtagNode("#"+search, 280, random(360));
    //myTwitterGraph.addWeakSpring("#"+search, global.id);
    //node.numConnections++;
    hashCount++;
  }
}

class Color {

  color c;

  Color(color cc) {
    c = cc;
  }

  color col() {
    return c;
  }
}

/*
** EDITED
 **
 ** Fixed the average color of the sentiments
 ** You have to change entire averagingColor() method
 ** The only thing is that sometimes the central graph is flickering, I will understand why :\
 **
 */

void averagingColor() {

  float r = 0;
  float g = 0;
  float b = 0;

  if (averageColor.size() > 1) {
    for (int i = 0; i < averageColor.size(); i++) {
      Color c = averageColor.get(i);
      r += red(c.col());
      g += green(c.col());
      b += blue(c.col());
    }
  }

  r /= averageColor.size();
  g /= averageColor.size();
  b /= averageColor.size();

  averageSentiment = color(r, g, b);

  int sum = 0;
  for (Integer n : avg) {
    sum += n;
  }

  if (avg.size() > 0) avgsentiment = constrain(sum/avg.size(), 0, 100);
}

void backg() {

  colorMode(RGB, 255);

  for (int x = width/64; x < width; x += width/64) {
    for (int y = height/36; y < height; y += height/36) {
      stroke(255, 175);
      strokeWeight(1);
      point(x, y);
    }
  }

  if (random(1) > 0.5) {
    for (int x = width/64; x < width; x += width/64) {
      for (int y = height/36; y < height; y += height/36) {
        float r = random(1);
        stroke(255, 125);
        strokeWeight(1);
        if (r > 0.99) {
          line(x, y, x+width/64, y);
        }
      }
    }
  }

  stroke(255, 100);
  line((width/64)*13, height*0.5, (width/64)*26, height*0.5);
  line(width-(width/64)*13, height*0.5, width-(width/64)*26, height*0.5);
  line(width*0.5, (height/36)*7, width*0.5, (height/36)*14);
  line(width*0.5, height-(height/36)*7, width*0.5, height-(height/36)*14);
}

void resetGraph() {
  // background(255);
  //keywords[0] = value;
  //resetNodes = true;

  //twitterStream.shutdown();
  //setup();
  //Clears Hashtags
  thcnodes.clear();

  //Clears tweets
  myTwitterGraph.removeNodes();
  //background(255);

  twitterStream.clearListeners();
  FilterQuery filtered = new FilterQuery();
  filtered.track(keywords);
  twitterStream.addListener(listener);

  if (keywords.length==0) {
    // sample() method internally creates a thread which manipulates TwitterStream 
    twitterStream.sample(); // and calls these adequate listener methods continuously.
  } else { 
    twitterStream.filter(filtered);
  }
}


//Spacebrew methods
void onRangeMessage( String name, int value ) {
  //println("got range message " + name + " : " + value);

  if ( name.equals("circularSlider")) {
    //println("got range message " + name + " : " + value);

    slider1 = value-180;
    println("circularSliderValue = " + slider1);
  } else if ( name.equals("XData")) {
    dataX = map(value, 0, 1000, -100,100);
        println("DataX: " + dataX);

  } else if (name.equals("YData")) {
    dataY = map(value, 0, 1000, -100,100);
        println("DataY: " + dataY);

  }
}

void onBooleanMessage(String name, boolean value) {
  if (name.equals("refreshButton")) {
    int counter = 0;

    if (value == true && counter ==0) {
      println("got boolean message " + name + " : " + value);
      resetGraph();
      counter++;
    } else {
      thcClicked = false;
      println("got boolean message " + name + " : " + value);
      //counter = 0;
    }
  }

  if (name.equals("toggle")) {
    int counter = 0;

    if (value == true && counter == 0) {
      toggleText = true;
      println("got boolean message " + name + " : " + value);

      counter++;
    } else {
      toggleText = false;
      println("got boolean message " + name + " : " + value);
    }
  }
  if (name.equals("circularSliderActive")) {
    circularSliderActive = value;
  }
  if (name.equals("XYActive")) {
    XYActive = value;
    if (value == false) {
      thcClicked = true;
    } else {
      thcClicked = false;
    }
  }
}

void onStringMessage(String name, String value) {
  println("got boolean message " + name + " : " + value);
  if (name.equals("filter")) {
    keywords[0] = value;
    //resetNodes = true;

    //twitterStream.shutdown();
    //setup();
    //Clears Hashtags
    thcnodes.clear();

    //Clears tweets
    myTwitterGraph.removeNodes();
    //background(255);

    twitterStream.clearListeners();
    FilterQuery filtered = new FilterQuery();
    filtered.track(keywords);
    twitterStream.addListener(listener);

    if (keywords.length==0) {
      // sample() method internally creates a thread which manipulates TwitterStream 
      twitterStream.sample(); // and calls these adequate listener methods continuously.
    } else { 
      twitterStream.filter(filtered);
    }
  }
}