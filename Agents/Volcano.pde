class Volcano{
 //Volcano image from pixshark.com
 
 //This class isn't really used anymore...
 public Volcano()
{
}
  
  public void display()
  {
    fill(101,67,33);
    noStroke();
    //The base
    triangle(10,800,400,450,790,800);
    //The middle
    triangle(100,800,400,300,700,800);
    //The tip
    triangle(200,800,400,200,600,800);
    fill(0);
    
  }
  
}
