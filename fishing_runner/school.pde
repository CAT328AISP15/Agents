class school 
{
  ArrayList<fish> school;
  
  school() 
  {
    school = new ArrayList<fish>();
  }

  void run() 
  {
    for (fish a : school) 
    {
      a.run(school);
    }
  }

  void addFish(fish b) 
  {
    school.add(b);
  }

}
