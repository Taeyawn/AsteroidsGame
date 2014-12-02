Star [] stars = new Star[200];
ArrayList<Asteroid> yawn = new ArrayList<Asteroid>();
boolean wIsPressed = false;
SpaceShip matt = new SpaceShip();
Asteroid tae = new Asteroid();
boolean dIsPressed = false;
boolean aIsPressed = false;
public void setup() 
{
  background(0);
  size (800,800);
  for(int i =0; i<200; i++)
  {
    stars[i] = new Star();
  }
  for(int i = 0;i<10; i++)
  {
    yawn.add(i, new Asteroid());
  }
}
public void draw() 
{
  background(0);
  for(int i = 0; i<200; i++)
  {
  stars[i].show();
  }
  matt.show();
  matt.move();
  tae.show();
  tae.move();
  if(wIsPressed == true && aIsPressed == true)
  {
    matt.accelerate(.1);
    matt.rotate(-5);
  }
  else if(wIsPressed == true && dIsPressed == true)
  {
    matt.accelerate(.1);
    matt.rotate(5);
  }
  else if(wIsPressed == true)
  {
    matt.accelerate(.1);
  }
  else if(aIsPressed == true)
  {
    matt.rotate(-5);
  }
  else if(dIsPressed == true)
  {
    matt.rotate(5);
  }
  for(int i = 0; i<yawn.size(); i++)
  {
    yawn.get(i).show();
    yawn.get(i).move();
    if(dist((float)yawn.get(i).myCenterX + 10, (float)yawn.get(i).myCenterY + 10, (float)matt.myCenterX, (float)matt.myCenterY)<20 || dist((float)yawn.get(i).myCenterX-10, (float)yawn.get(i).myCenterY-10, (float)matt.myCenterX, (float)matt.myCenterY)<20)
    {
      yawn.remove(i);
    } 
  }
}
class SpaceShip extends Floater  
{   
  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY = y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX = x;}
  public double getDirectionX(){return (double)myDirectionX;}
  public void setDirectionY(double y){myDirectionY = y;}
  public double getDirectionY(){return (double)myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection = degrees;}
  public double getPointDirection(){return (double)myPointDirection;}
  SpaceShip()
  {
    corners = 3;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -8;
    yCorners[0] = -8;
    xCorners[1] = -8;
    yCorners[1] = 8;
    xCorners[2] = 16;
    yCorners[2] = 0;
    myColor = color(255);
    myCenterX = 400;
    myCenterY = 400;
  }
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    } 
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 
public void keyPressed()
{
  if(key=='h')
  {
    matt.setDirectionX(0);
    matt.setDirectionY(0);
    matt.setX((int)(Math.random()*800));
    matt.setY((int)(Math.random()*800));
    matt.setPointDirection((int)(Math.random()*360));
  }
  if(key=='w')
  {
    wIsPressed = true;
  }
  if(key=='a')
  {
    aIsPressed = true;
  }
  if(key=='d')
  {
    dIsPressed = true;
  }
}

public void keyReleased()
{
  if(key=='w')
  {
    wIsPressed = false;
  }
  if(key=='a')
  {
    aIsPressed = false;
  }
  if(key=='d')
  {
    dIsPressed = false;
  }  
}
class Star
{
  int myX;
  int myY;
  Star()
  {
    myX = (int)(Math.random()*800);
    myY = (int)(Math.random()*800);
    
  }
  public void show()
  {
    fill(255,255,0);
    ellipse(myX,myY,5,5);
  }
}

class Asteroid extends Floater
{
  private double rotSpeed;
  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY = y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX = x;}
  public double getDirectionX(){return (double)myDirectionX;}
  public void setDirectionY(double y){myDirectionY = y;}
  public double getDirectionY(){return (double)myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection = degrees;}
  public double getPointDirection(){return (double)myPointDirection;}
  Asteroid()
  {
    rotSpeed = Math.random()*2-1;
    corners = 6;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -20;
    yCorners[0] = -16;
    xCorners[1] = 24;
    yCorners[1] = -22;
    xCorners[2] = 15;
    yCorners[2] = 8;
    xCorners[3] = 17;
    yCorners[3] = 15;
    xCorners[4] = -12;
    yCorners[4] = 10;
    xCorners[5] = -20;
    yCorners[5] = -13;
    myColor = color(255,0,0);
    myCenterX = (int)(Math.random()*800);
    myCenterY = (int)(Math.random()*800);
    myDirectionX = (Math.random()*7-3);
    myDirectionY = (Math.random()*7-3);
  }
  public void move()
  {
    myCenterX += myDirectionX;   
    myCenterY += myDirectionY;
    myPointDirection += rotSpeed;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    } 
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }
}

