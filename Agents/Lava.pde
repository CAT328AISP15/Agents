//Nothing too special about this lava class. Lava is affected by gravity (so it falls)
//Has a switch statement that determines what color the lava is.

class Lava
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector startDirection;
  PVector gravity;
  float maxForce;    
  float maxSpeed; 
  float lifeSpan;
  float choice; //= random(4)-2;
  float explosiveForce;
  int colors ;//= int(random(2));
  float r;
  
  Lava()
  {
    explosiveForce = random(6)-9;
    location = new PVector(425,375);
    acceleration = new PVector(0,explosiveForce);
    velocity = new PVector(0,0);
    gravity = new PVector(0,.1);
    
    colors = int(random(2));
    choice = random(4)-2;
    startDirection = new PVector(choice, 0);
    applyForce(startDirection);
    
    maxSpeed = 3;
    maxForce =.03;
    lifeSpan = 350;    
    r= 20;
  }
  
  void run()
  {
    display();
    update();    
    
  }
  
  void display() 
  {
    //ellipseMode(CORNER);
    
    switch(colors)
    {
      case 0:
        fill(255,70,3,lifeSpan);
        break;
      
      case 1:
        fill(255,180,3,lifeSpan);
        break;
        
      default:
        fill(255,70,3,lifeSpan);
        break;    
    }
    
    noStroke();
    ellipse(location.x,location.y,r,r);
  }
  
  void update()
  {
    
    //startDirection = new PVector(choice, 0);
    //applyForce(startDirection);
    applyForce(gravity);
    velocity.add(acceleration);
    //velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
    lifeSpan-=1;
  }
  
  void applyForce(PVector force)
  {
  acceleration.add(force);
  }
  
  
  
  boolean colliding (float x, float y)
  {
    if(dist(location.x, location.y, x, y) < this.getR()*2 )
    return true;
    else 
    return false;
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
  
  
  PVector getLoc()
  {
    return location;
  }
  
  float getR()
  {
    return r;
  }
  
}
