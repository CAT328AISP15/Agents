// world - environment for all elements
// K.Garnett
// 4/28/15
// Background sprites from Sonic Advance 3, property of SEGA®
//liquid code from shiffman


public class World
{
  PImage background;
  PImage bridge = loadImage("unnamed.png");
  PImage fisher = loadImage("fisher.png");

  PVector wind;
  float angle = PI/4;
  PVector location = new PVector(170, 155);

  boolean thrown = false;

  school fishes;
  Liquid l;
  bob bobber;


  World(int type) //number between 1-5 determining wind speed
    // and background color

  {
    if (type == 1)
    {
      background = loadImage("dayLight.png");
      wind = new PVector( -0.02, 0.0);
    } else if (type == 2)
    {
      background = loadImage("nightTime.png");
      wind = new PVector( 0.04, 0.0);
    } else if (type == 3)
    {
      background = loadImage("overcast.png");
      wind = new PVector( -0.1, 0.0);
    } else if (type == 4)
    {
      background = loadImage("Dusk.png");
      wind = new PVector( 0.03, 0.0);
    } else if (type == 5)
    {
      background = loadImage("twilight.png");
      wind = new PVector( 0.0, 0.0);
    } else
    {
      background = loadImage("daylight.png");
      wind = new PVector(0, 0);
    }

    l = new Liquid(3);
    fishes = new school();

    for (int i = 0; i < 25; i++) 
    {
      fish a = new fish(width/6, height/6);
      fishes.addFish(a);
    }
    
    bobber = new bob(location);
  }

  void render()
  {
    l.display();
    image(background, 0, 0);
    fishes.run();
    image(bridge, width-96, 120);
    image(bridge, 0, 120);
    image(fisher, width-98, 155);

    if (thrown) 
    {
      PVector gravity = new PVector(-0.3, 0.2);
      bobber.applyForce(gravity);
      bobber.applyForce(mobius.wind);
      
      if(l.contains(bobber))
      {
        bobber.applyForce(l.drag(bobber));
        bobber.applyForce(new PVector(0.5, 0));
      }
      bobber.update();
    }
    bobber.display();

    if (bobber.location.y > 290) 
    {
      bobber = new bob(location);  
      thrown = false;
    }
  }
}

