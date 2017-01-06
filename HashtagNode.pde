class HashtagNode {

  // All the usual stuff
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed

  float ray;
  float ellipseDiameter;
  float nDiameter;

  String theHashtag;
  String finalHashtag;
  int sCounter = 0;

  float lifetime;
  float life;

  boolean isClicked = false;
  boolean isHighlighted = false;



  //float bloom = 0;
  //PVector blooma = new PVector(0, 0);
  boolean updatepos = true;

  Bloom blooma;

  String text;

  int counter = 0;
  int numConnections = 0;
  StringList tweetTexts;
  
  Boolean textDisplay = true;


  HashtagNode(PVector l, float lf, String th, String tweetText) {
    location = l;
    ray = 40;
    ellipseDiameter = 0;
    nDiameter = 5;
    maxspeed = 5;
    maxforce = 1;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);

    lifetime = lf;
    life = lifetime;

    finalHashtag = th;
    theHashtag = "";
    //this.text = text;
      tweetTexts = new StringList();
    tweetTexts.append(tweetText);
    numConnections = 0;
  }
  
  void addTweetText(String tweet){
    tweetTexts.append(tweet);
  }
  
  void toggleTextDisplay(){
    textDisplay = !textDisplay;
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    PVector dir = PVector.sub(force, acceleration);
    PVector vel = PVector.div(dir, 10);
    acceleration.add(vel);
  }

  void applyBehaviors(ConcurrentHashMap<Integer, HashtagNode> vehicles) {
    if (!isClicked) {
      PVector separateForce = separate(vehicles);
      PVector seekForce = seek();
      separateForce.mult(2);
      seekForce.mult(1);
      applyForce(separateForce);
      applyForce(seekForce);
    } else {
      PVector np = new PVector(width/2, height/2);
      PVector dir = PVector.sub(np, location);
      PVector vel = PVector.div(dir, 7);
      location.add(vel);
    }
  }

  // A method that calculates a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek() {
    PVector target = new PVector(width/2, height/2);
    //target = new PVector(width/2, height/2);
    //if (!isClicked) target = new PVector(width/2, height/2); 
    //else target = new PVector(width/2, height/2);
    PVector desired = PVector.sub(target, location);  // A vector pointing from the location to the target

    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force

    return steer;
  }

  // Separation
  // Method checks for nearby vehicles and steers away
  PVector separate (ConcurrentHashMap<Integer, HashtagNode> vehicles) {
    float desiredseparation = ray*2;
    PVector sum = new PVector();
    int count = 0;
    // For every boid in the system, check if it's too close
    //for (HashtagNode other : vehicles) {
    //  float d = PVector.dist(location, other.location);
    //  // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
    //  if ((d > 0) && (d < desiredseparation)) {
    //    // Calculate vector pointing away from neighbor
    //    PVector diff = PVector.sub(location, other.location);
    //    diff.normalize();
    //    diff.div(d);        // Weight by distance
    //    sum.add(diff);
    //    count++;            // Keep track of how many
    //  }
    //}

    Iterator iter = vehicles.entrySet().iterator();

    while (iter.hasNext()) {
      Map.Entry me = (Map.Entry) iter.next();

      HashtagNode other = (HashtagNode) me.getValue();

      float d = PVector.dist(location, other.location);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);        // Weight by distance
        sum.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      sum.div(count);
      // Our desired vector is the average scaled to maximum speed
      sum.normalize();
      sum.mult(maxspeed);
      // Implement Reynolds: Steering = Desired - Velocity
      sum.sub(velocity);
      sum.limit(maxforce);
    }
    return sum;
  }

  void update() {

    if (sCounter < finalHashtag.length() && frameCount%2 == 0) {
      theHashtag += finalHashtag.charAt(sCounter);
      sCounter++;
    }

    if (isClicked && updatepos) {
      blooma = new Bloom(location);
      //blooma = location;
      updatepos = false;
    }

    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);

    // Separate from the center
    if (!isClicked) {
      float desiredseparation = 300;
      PVector sum = new PVector();
      PVector center = new PVector(width/2, height/2);
      float d = PVector.dist(location, center);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(location, center);
        diff.normalize();
        diff.div(d);        // Weight by distance
        sum.add(diff);
      }
      sum.normalize();
      sum.mult(maxspeed*10);
      // Implement Reynolds: Steering = Desired - Velocity
      sum.sub(velocity);
      sum.limit(maxforce*2);
      applyForce(sum);
      life -= 20;
    }
    counter++;

    float ndd = nDiameter - ellipseDiameter;
    float vdd = ndd/15;
    ellipseDiameter += vdd;
    
    ellipseDiameter = constrain(ellipseDiameter, 0, 100);
  }

  void display() {
    ellipseMode(RADIUS);
    if (!isHighlighted) {
      fill(255);
      noStroke();
      ellipse(location.x-ellipseDiameter/2, location.y, ellipseDiameter, ellipseDiameter);
    } else {
      stroke(255);
      line(width/2, height/2, location.x-ellipseDiameter/2, location.y);
      stroke(255, 100, 0);
      fill(255);
      ellipse(location.x-ellipseDiameter/2, location.y, ellipseDiameter, ellipseDiameter);
      fill(255, 100, 0);
      ellipse(location.x-ellipseDiameter/2, location.y, 4, 4);
      if (location.y < height/2) {
        if (location.x-ellipseDiameter/2 < width/2) {
          line(-ellipseDiameter/2, location.y, location.x-ellipseDiameter/2, location.y);
          line(location.x-ellipseDiameter/2, 0, location.x-ellipseDiameter/2, location.y);
        } else if (location.x-ellipseDiameter/2 >= width/2) {
          line(width, location.y, location.x-ellipseDiameter/2, location.y);
          line(location.x-ellipseDiameter/2, 0, location.x-ellipseDiameter/2, location.y);
        }
      } else if (location.y >= height/2) {
        if (location.x-ellipseDiameter/2 < width/2) {
          line(-ellipseDiameter/2, location.y, location.x-ellipseDiameter/2, location.y);
          line(location.x-ellipseDiameter/2, height, location.x-ellipseDiameter/2, location.y);
        } else if (location.x-ellipseDiameter/2 >= width/2) {
          line(width, location.y, location.x-ellipseDiameter/2, location.y);
          line(location.x-ellipseDiameter/2, height, location.x-ellipseDiameter/2, location.y);
        }
      }
      fill(255);
      noStroke();
      ellipse(width/2, height/2, 4, 4);
      //fill(255, 131, 0);
      //ellipse(location.x-ellipseDiameter/2, location.y, ellipseDiameter*4, ellipseDiameter*4);
    }
    fill(255);
    textAlign(LEFT, CENTER);
    pushStyle();
    textFont(font2, 22);
    
    if(textDisplay){
    text("#" + theHashtag, location.x + ellipseDiameter*0.8, location.y);
    }
    popStyle();

    if (counter < 2) {
      stroke(255, 100, 0);
      line(width/2, height/2, location.x, location.y);
      stroke(255);
      if (location.y < height/2) {
        if (location.x < width/2) {
          line(0, location.y, location.x, location.y);
          line(location.x, 0, location.x, location.y);
        } else if (location.x >= width/2) {
          line(width, location.y, location.x, location.y);
          line(location.x, 0, location.x, location.y);
        }
      } else if (location.y >= height/2) {
        if (location.x < width/2) {
          line(0, location.y, location.x, location.y);
          line(location.x, height, location.x, location.y);
        } else if (location.x >= width/2) {
          line(width, location.y, location.x, location.y);
          line(location.x, height, location.x, location.y);
        }
      }
    }

    if (blooma != null) {
      blooma.run();
    }
  }

  int getAngle() {
    float a = atan2(location.y-height/2, location.x-width/2);
    int angle = int(degrees(a));
    return angle;
  }
}

class Bloom {

  PVector bl;
  float alpha;

  Bloom(PVector l) {
    bl = new PVector(l.x, l.y);
    alpha = 0;
  }

  void run() {
    float a = map(alpha, 0, 255, 255, 0);
    //float a = 255.0;
    float nb = 255;
    float db = nb-alpha;
    float vb = db/7;
    alpha += vb;

    stroke(255, a);
    noFill();
    ellipse(bl.x, bl.y, map(alpha, 0, 255, 0, width), map(alpha, 0, 255, 0, width));
  }
}