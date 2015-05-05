class fish
{

  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;
  int count;
  

  fish(float x, float y) 
  {
    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-1, 1), random(-1, 1));
    location = new PVector(x, y);
    r = 3.0;
    maxspeed = 3;
    maxforce = 0.05;
  }

  void run(ArrayList<fish> school) 
  {
    flock(school);
    flee(mobius.bobber.location);
    update();
    borders();
    render();
  }

  void applyForce(PVector force) 
  {
    acceleration.add(force);
  }

  void flock(ArrayList<fish> school) 
  {
    PVector sep = separate(school);
    sep.mult(1.5);
    applyForce(sep);
  }

  void update() 
  {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  PVector seek(PVector target) 
  {
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxspeed);

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce); 
    return steer;
  }

  void flee(PVector target)
  {
    PVector desired = PVector.sub(location, target);
    float distance = desired.mag();
    PVector steering;
    if (distance > 0 && distance < 50)
    {
      desired.normalize();
      desired.mult(maxspeed);
      steering = PVector.sub(desired, velocity);
      steering.limit(maxforce);
    } else steering = new PVector(0, 0);
    applyForce(steering);
  }
  void render() 
  {

    float theta = velocity.heading2D() + radians(90);
    fill(175);
    stroke(0);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }

  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < 210-r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }

  PVector separate (ArrayList<fish> school) 
  {
    float desiredseparation = 25.0;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;

    for (fish other : school) 
    {
      float d = PVector.dist(location, other.location);

      if ((d > 0) && (d < desiredseparation)) 
      {
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);  
        steer.add(diff);
        count++;
      }
    }

    if (count > 0) {
      steer.div((float)count);
    }

    if (steer.mag() > 0) {
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }
}

