//Makes a system of FlowVehicles. Not much different from other systems
//i've done.

class FlowSystem
{
  ArrayList<FlowVehicle> particles;
  
  FlowSystem()
  {
    particles = new ArrayList<FlowVehicle>();
  }
  
  void addVehicle(int howMany)
  {
   for(int i = 0; i<howMany; i++)
   {
     particles.add(new FlowVehicle()); 
   }
  }
  
  
  
   void follow(FlowField flow)
  {
    for(FlowVehicle f:particles)
    {
      f.follow(flow);
    }
  }
  
  
  
  void run()
  {
    for(int i = particles.size()-1; i>=0; i--)
    {
      FlowVehicle vehicle = particles.get(i);
      vehicle.run();
            
     if(vehicle.isDead())
          {
            particles.remove(i);
          }
    }
    
  }
  
  ArrayList<FlowVehicle> getArray()
    {
     return particles; 
    }
  
}
