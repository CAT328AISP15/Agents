//Class that makes a flowfield over the background image. Flow paths
//are determined by the brightness of the image.

class FlowField 
{
  PVector[][] field;
  int columns;
  int rows; 
  int resolution;
  
  PImage img;

  FlowField() 
  {
    resolution = 25;
    columns = width/resolution;
    rows = height/resolution;//*20;
    field = new PVector[columns][rows];
    img = loadImage("Volcano.jpg");
    init();
  }
  
  
  
  void init() 
    {
      for (int i = 0; i < columns; i++) 
      {
        for (int j = 0; j < rows; j++) 
        {
          field[i][j] = new PVector(width/2-i*resolution,height/2-j*resolution);
          field[i][j].normalize();
        }
      }

      //
      for (int i = 1; i < columns-1; i++) 
      {
        for (int j = 1; j < rows-1; j++) 
        {
  
          int x = i*resolution;
          int y = j*resolution;
          //pixels[] doesn't work unless you load the image into this class and then call
          //loadPixels(). Throws a nullPointer or outOfBounds exception (I don't remember which)
          //without updating pixels after even though i'm not changing them.
          loadPixels();
          int c = img.pixels[x + y * img.width];
          updatePixels();
  
          // Makes it so that brightness is converted into an angle
          float angle = map(brightness(c), 0, 255, 0, TWO_PI);
          // Makes this index of the 2D-Array a vector based on the angle 
          field[i][j] = PVector.fromAngle(angle);
          //Sets magnitude to one
          field[i][j].normalize();
        }
      }
  }
  
  PVector lookup(PVector lookup) 
  {
    int column = int(constrain(lookup.x/resolution, 0, columns-1));
    int row = int(constrain(lookup.y/resolution, 0, rows-1));
    return field[column][row].get();
  }

  
}

