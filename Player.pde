class Player
{
  PImage playerImg;  
  PImage playerBullet;
  int Health = 500;
  
  float x = 50, y = 50, x_added = 40, y_added = 50;
  
 // boolean Left = false, Right = false;
  
  ArrayList <PlayerBullet1> m_PlayerBullet1 = new ArrayList <PlayerBullet1> ();
  Shield m_Shield;
  
  boolean UseShield = false;
  
  void SetupPlayerImage()
  {
    playerImg = loadImage("player.png");
    m_Shield = new Shield (x + 40, y, 5, 50);
    
  } 
  void Update()
  {
   
    movement();
    UpdateBullet();
    CheckBulletDead();
    
    //UpdateShield();
    
    image(playerImg, x, y, x_added, y_added);
    //rect (x, y, x_added, y_added);    
  }
  
  void UpdateShield()
  {
    m_Shield.drawObj();
  } 
  
  void UpdateBullet()
  {    
    for (int i = 0; i < m_PlayerBullet1.size(); i++)
    {
      PlayerBullet1 pb1 = m_PlayerBullet1.get(i);
      pb1.moveForward();
      pb1.drawObj();
      pb1.checkBulletDead();
    }     
  } 
  
  void CheckBulletDead()
  {
    for (int i = 0; i < m_PlayerBullet1.size(); i++)
    {
      PlayerBullet1 pb1 = m_PlayerBullet1.get(i);
      
      if(pb1.isDead) m_PlayerBullet1.remove(i);
      
    }    
  }
    
  void movement()
  {
    y += 3;   
    
    if (x < 0) x = 0;
    else if (x > width - 30) x = width - 30;
  }
  
  void Fire()
  {
    m_PlayerBullet1.add (new PlayerBullet1 (x + 30, y + 25, loadImage("bullet.png"), 50, 10, 10));    
  }
  
  void UseShield()
  {
    if (mouseX < x) m_Shield = new Shield (x, y, -10, 50);
    else if (mouseX > x) m_Shield = new Shield (x + 40, y, 10, 50);
    
  }
  
} 