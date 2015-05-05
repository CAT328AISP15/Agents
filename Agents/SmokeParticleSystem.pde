//Read comment in class SmokeParticle

class SmokeParticleSystem {

  ArrayList<SmokeParticle> particles;    
  PVector origin;                   
  //PImage img;
  
  SmokeParticleSystem(int num, PVector v) 
  {
    particles = new ArrayList<SmokeParticle>();              
    origin = v.get();                                   
    
    for (int i = 0; i < num; i++) 
    {
      particles.add(new SmokeParticle(origin));         
    }
  }
  
  
  void addParticle() 
  {
    particles.add(new SmokeParticle(origin));
  }



  void run()
  {
    for (int i = particles.size()-1; i>=0; i--)
    {
      SmokeParticle smoke = particles.get(i);
      smoke.run();
      
      if (smoke.isDead())
      {
        particles.remove(i);
      }
    }
  }
  
  
  
  void applyForce(PVector direction)
  {
    
    for (SmokeParticle s: particles)
    {
      s.applyForce(direction);
    }
  
  }  
  
  int getSize()
  {
   return particles.size(); 
  }

  

}
