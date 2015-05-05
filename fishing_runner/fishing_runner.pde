
World mobius;

void setup()
{
  size(256, 300);
  mobius = new World(1);
}

void draw()
{
  mobius.render();

}
void mouseDragged() 
{
  mobius.fishes.addFish(new fish(mouseX, mouseY));
}

void keyPressed() 
{
  if (key == CODED && keyCode == RIGHT) 
  {
    mobius.angle += 0.1;
  } else if (key == CODED && keyCode == LEFT) 
  {
    mobius.angle -= 0.1;
  } else if (key == ' ') 
  {
    mobius.thrown = true;
    PVector force = PVector.fromAngle(mobius.angle);
    force.mult(8);
    mobius.bobber.applyForce(force);
  }
}

