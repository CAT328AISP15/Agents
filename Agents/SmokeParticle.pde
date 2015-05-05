//Previosly this served in a system of like particles that created some 
//smoldering clouds that rose from the volcano mouth. No longer used.
//It doesn't look right with the image I placed.

class SmokeParticle 
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  //PImage img;

  SmokeParticle(PVector loc) 
  {
    acceleration = new PVector(0,0);
    float vx = randomGaussian()*0.3;
    float vy = randomGaussian()*0.3 - 1.0;
    velocity = new PVector(vx,vy);
    location = loc.get();
    lifespan = 400;
    
  }

  void run() 
  {
    display();
    update();    
  }
  

  void applyForce(PVector force) 
  {
    acceleration.add(force);
  }  


  void update()
  {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2;
    acceleration.mult(0);
  }

  
  void display() 
  {
     fill(150,lifespan);
     noStroke();
     ellipse(location.x,location.y,40,40);
  }

  
  boolean isDead() 
  {
    if (lifespan <= 0.0) 
    {
      return true;
    } else 
    {
      return false;
    }
 }
}
