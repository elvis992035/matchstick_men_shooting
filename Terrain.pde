class Terrain
{  
    
  float x, y, x_added, y_added;
  
  Terrain (float x1, float y1)
  {    
    x = x1;
    y = y1;
    x_added = 200;
    y_added = height;    
  } 
  
  void updateTerrain()
  {
    
    drawobj();    
       
  }
  
  void drawobj()
  {
    
    fill (0);
    rect (x, y, x_added, y_added);
        
  } 
  
  boolean CheckPlayerStanding(Player p)
  {
    
    if (p.x + p.x_added <= x || p.y + p.y_added <= y
    || p.x >= x + x_added || p.y >= y + y_added)
    {
      return false;
    } else 
    {
      return true;
    } 
        
  }
  
  boolean CheckEnemy1Standing(Enemy1 e)
  {
    
    if (e.x + e.x_added <= x || e.y + e.y_added <= y
    || e.x >= x + x_added || e.y >= y + y_added)
    {
      return false;
    } else 
    {
      return true;
    } 
        
  }
} 