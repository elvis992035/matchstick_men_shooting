class Shield
{
  
  float x, y, x_added, y_added = 50;
  
  boolean isDead = false;
  
  Shield (float x1, float y1, float x_added1, float y_added1)
  {
    x = x1;
    y = y1;
    x_added = x_added1;
    y_added = y_added1;
  }
  
  void drawObj()
  {
    noStroke();
    fill(155);
    rect(x, y, x_added, y_added);
  }
  
} 