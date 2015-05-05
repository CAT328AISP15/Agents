//Been writing a lot of vehicle classes. Most should seem familiar to you

//So far I have been unable to make this path following class work :'[ 
//I'm not sure what I need to do to satisfy this requirement. (at least to make this work)
//Unfortunately (and this is my fault), it's too late to send this to you and ask for feedback :/
//Hopefully, you won't hold this too heavily against me (I've really been busting it for this project)
//I would like to say that through this final project, I really have learned a lot and have become
// very familiar and comfortable with many of the concepts. Anyways, I hope you like and appreciate
// this program for what it is. I worked hard, hopefully it's evident.

class FollowPath
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float r;
  
  float maxforce;
  float maxspeed; 
  
  Path p;


  FollowPath()
  {
    location = new PVector(800, 600);
    acceleration = new PVector(0, 0);
    velocity = new PVector(maxspeed, 0);
    
    r = 4.0;
    maxspeed = 5;
    maxforce = .5;
    
    p = new Path();
  }



  void run() 
  {
    update();
    display();
  }


//Took me at least a week to understand this... -_-
  void follow() 
  {
    //determines the direction in which it's moving
    PVector step = velocity.get();
    step.normalize();
    step.mult(50);
    PVector nextStep = PVector.add(step,location);

    //gets the vectors of the start and end positions.
    PVector start = p.start;
    PVector end = p.end;

    // Get the normal point to that line. Normal point is perpendicular? 
    PVector normalPoint = getNormalPoint(nextStep, start, end);

    //To move toward where you're going to
    PVector direction = PVector.sub(end, start);
    direction.normalize();
    direction.mult(10);  
    PVector target = PVector.add(normalPoint, direction);

  
    float distance = PVector.dist(nextStep, normalPoint);
    
    //to get back to the path if the object is veered off, this shouldn't happen though.
    //Guess I need to put it in though otherwise, it wouldn't really be path finding..?
    if (distance > p.rad) 
    {
      seek(target);
    }

  }


  //As the name suggests, helps get the normal point to a line
  PVector getNormalPoint(PVector point, PVector start, PVector end) 
  {
    PVector a = PVector.sub(point, start);
    PVector hypotenuse = PVector.sub(end, start);
    
    hypotenuse.normalize();
    hypotenuse.mult(a.dot(hypotenuse));
    PVector normalPoint = PVector.add(start, hypotenuse);
    return normalPoint;
  }




  void update() 
  {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
    wrapAround(p);
  }

//nothing new...
  void applyForce(PVector force)
  {
    acceleration.add(force);
  }


  void seek(PVector target) 
  {
    PVector desired = PVector.sub(target, location);
    
    //From what I understand, the computer will exit this statement if it tests true
    if (desired.mag() == 0) 
      return;

    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce); 
    applyForce(steer);
  }

  void display()
  {
    //Similar to what I did in FlowVehicle to make object turn in the direction it's moving.
    float angle = velocity.heading2D() + radians(90);
    fill(102,51,0);
    stroke(0);
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    rect(location.x, location.y, 30, 10);
    rect(location.x, location.y +10,10,20);
    rect(location.x + 20, location.y +10, 10, 20);
    popMatrix();
  }

//To keep the object from going out of bounds of the window (techinically the path, but they should be the same)
  void wrapAround(Path p) 
  {
    if (location.x > p.end.x + r) 
    {
      location.x = p.start.x - r;
      location.y = p.start.y + (location.y-p.end.y);
    }
  }
}

