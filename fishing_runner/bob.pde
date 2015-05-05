// fisherbot - user controller object,
// 4/28/15
// K.Garnett

public class bob
{

  PVector location;
  PVector accel;
  PVector velocity;

  float r = 5;
  float maxspeed = 1;

  public bob(PVector loc)
  {
    location = loc;
    accel = new PVector(0, 0);
    velocity = new PVector(0, 0);
  }

  void applyForce( PVector force)
  {
    accel.add(force);
  }

  void update()
  {
    velocity.add(accel);
    velocity.limit(maxspeed);
    location.add(velocity);
    accel.mult(0);
  }

  void display()
  {
    noStroke();
    fill(125, 100, 123);
    pushMatrix();
    translate(location.x, location.y);
    ellipse(0, 0, r*2, r*2);
    popMatrix();
  }
}
