//Class to make a vehicle that follows the flow field
class FlowVehicle 
{
//Normal variable declarations
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    
  float maxspeed;    
  int lifeSpan;

  FlowVehicle() 
  {
    //Initiallizing variables
    
    //Makes it so that while vehicles are close, all vehicles don't spawn
    //in the same place.
    float x = random(30)-15;
    //float x = random(100)-50;
    location = new PVector(425+x,400);
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    
    r = 3;
    maxspeed = 1.5;
    maxforce = .1;    
    
    lifeSpan = 150;
  }
  
  
  
  void display()
  {
    //To make it so that the triangle points in the direction it's moving
    //This took me a while to get down right. Shiffman pointed me in the right
    //direction through his videos.
    float angle = velocity.heading2D() + radians(90);
    fill(255,180,3,lifeSpan);
    pushMatrix();
    translate(location.x,location.y);
    rotate(angle);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }
  

  public void run() 
  {
    update();
    display();
  }
  
  
  void applyForce(PVector force) 
  {
    acceleration.add(force);
  }



//Watched some videos to help me understand how this works.
//Seems similar to chase/seeking
  void follow(FlowField flow)
  { 
    //Gets the vector based on where the vehicle is on the flow field.
    PVector desired = flow.lookup(location);
    desired.mult(maxspeed);
    PVector steer = PVector.sub(velocity,desired);
    steer.limit(maxforce); 
    applyForce(steer);
  }
  


  void update() 
  {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
    lifeSpan-=1;
  }



    boolean isDead() 
  {
    if(lifeSpan <= 0)
    {
      return true;
    }
      else 
    {
      return false;
    }
  }
}


