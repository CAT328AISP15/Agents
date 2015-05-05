class LavaSystem
{
  ArrayList<Lava> particles;
  
  LavaSystem()
  {
    particles = new ArrayList<Lava>();
  }
  
  void addLava(int howMany)
  {
   for(int i = 0; i<howMany; i++)
   {
     particles.add(new Lava()); 
   }
  }
  
  void run()
  {
    for(int i = particles.size()-1; i>=0; i--)
    {
      Lava lava = particles.get(i);
      lava.run();
            
     if(lava.isDead())
          {
            particles.remove(i);
          }
    }
    
    
    
  }
  
  ArrayList<Lava> getArray()
    {
     return particles; 
    }
  
}
