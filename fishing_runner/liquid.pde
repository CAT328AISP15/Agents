class Liquid 
{
  float x,y,w,h;
  float c;

  Liquid(float c_) 
  {
    c = c_;
    
    x = 0;
    y = 155;
    w = 255;
    h = 300 - 155;
  }
  
  boolean contains(bob b) 
  {
    PVector l = b.location;
    if (l.x > x && l.x < x + w && l.y > y && l.y < y + h) {
      return true;
    }  
    else {
      return false;
    }
  }

  PVector drag(bob b) 
  {
    float speed = b.velocity.mag();
    float dragMagnitude = c * speed * speed;

    PVector dragForce = b.velocity.get();
    dragForce.mult(-1);

    dragForce.normalize();
    dragForce.mult(dragMagnitude);
    return dragForce;
  }
  
  void display() {
    noStroke();
    fill(0,120,255);
    rect(0,200,256,300-155);
  }

}
