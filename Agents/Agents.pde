//Tried to comment as much as I thought necessary.

//Realizing now that inheritance could have been used a lot in this program but it's too late to 
//change that.
FollowPath horseOrSomething;

Volcano volcano;
LavaSystem lava;
FlowField flowField;
FlowSystem stream;
ArrayList<Bird> birds;
SmokeParticleSystem smoke;

PImage img;

//This will go unused:
//float noiseScale;

void setup()
{
 size( 800, 800);
 
 volcano = new Volcano();
 lava = new LavaSystem();
 birds = new ArrayList<Bird>();
 
 flowField = new FlowField();
 stream = new FlowSystem();
 
 horseOrSomething = new FollowPath();
 //smoke = new SmokeParticleSystem(30,new PVector(425,375));
 
 //Volcano image from pixshark.com
 img = loadImage("Volcano.jpg");
 
 //noiseScale = 0;
 
 for (int i = 0; i < 20; i++) 
  {
   birds.add(new Bird(mouseX,mouseY));
  }
  
}

void draw()
{
 
 background(0);
 image(img,0,0,800,800);
 //volcano.display();
 //rect(350,200,100,75);
 stream.follow(flowField);
 stream.run();
 horseOrSomething.run();
 lava.run(); 
 //smoke.run();
 //smoke.addParticle();
 
 //I make this array so birds will check to see if they're colliding
 //with every lava object.
 ArrayList<Lava> l = lava.getArray();
 
 
 for(Bird bird: birds)
 {
  bird.display();
  bird.applyBehaviors(birds,mouseX,mouseY);
    for(Lava magma: l)
    {
      //So the birds can avoid the magma
     if (magma.colliding(bird.location.x,bird.location.y))
      bird.avoid(magma);  
     
    }
    bird.update();
 }
 
}

//So the volcano erupts with each click
void mousePressed()
{
 lava.addLava(50);
}

//Creates vehicles that move along the flowfield.
void mouseDragged() 
{
  stream.addVehicle(1);
}
