//Little birds that will follow the mouse and avoid lava.
//Disclaimer: This class stems from my flockBehaviors assigment and as 
// such is unnecessarily complicated... but it works.

class Bird
{
  //variable declaration
  float maxSpeed;
  float maxForce;
  float r;
  //float crad = 6;
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  Bird(float x, float y)
  {
    //initialization
    location = new PVector(x, y);
    r = 6;
    maxSpeed = 3;
    maxForce = 0.3;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    
  }
  
  void update()
  {
    
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display()
  {
    fill(255);
    //pushMatrix();
    //translate(location.x, location.y);
    triangle(location.x,location.y,location.x+3,location.y+6,location.x+6,location.y);
    //popMatrix();
    
  }
  
  
  void applyForce(PVector force)
  {
    acceleration.add(force);
  }
  
  PVector seek(PVector target) 
  {
   PVector desired = PVector.sub(target,location);
   desired.setMag(maxSpeed);
   PVector steer = PVector.sub(desired,velocity);
   steer.limit(maxForce); 
   return steer;
  }
  
  PVector separate(ArrayList<Bird> vehicles)
 {
   float howFarApart = r *1.5;
   PVector sum = new PVector();
   int count = 0;
   for(Bird other: vehicles)
   {
     float d = PVector.dist(location,other.location);
     
     if(d>0 && d<howFarApart)
     {
       PVector diff = PVector.sub(location,other.location);
       diff.normalize();
       diff.div(d);
       sum.add(diff);
       count++;
     }
   }
   if(count > 0)
   {
     sum.div(count);
     sum.normalize();
     sum.mult(maxSpeed);
     sum.sub(velocity);
     sum.limit(maxForce);
   }
   return sum;
  }
  
  
  
  void avoid(Lava circ) 
  {
   PVector c = circ.getLoc();

   
   PVector desired = PVector.sub(location,c);
   //desired.setMag(maxSpeed);
   PVector steer = PVector.sub(desired,velocity);
   steer.limit(40); 
   applyForce(steer);
  }
  
  
  
  void applyBehaviors(ArrayList<Bird> vehicles, float x, float y)
  {
   PVector getAway = separate(vehicles);
   PVector mouse = new PVector(x, y);
   
     
   
     //if (circ.colliding(location.x,location.y)){
   //avoid(circ);  
   //}//Otherwise, keep seeking the nomad (or the mouse if that's easier to understand)
   //else{
   PVector seekForce = seek(mouse);
   applyForce(seekForce);
   //}
   //And to always keep your distance from all other birds
   getAway.mult(1.2);
   applyForce(getAway);
  }
  
  
  
  float getX()
  {
   return location.x; 
  }
  
  
  
  float getY()
  {
   return location.y; 
  }
  
}
