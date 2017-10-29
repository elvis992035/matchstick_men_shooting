class Enemy
{
  PImage Enemy;
  PImage EnemyBullet;
  
  float x, y, x_added = 40, y_added = 50;  
  float speed;
  int health = 100;
  
  boolean isDead = false;  
  
  ArrayList <EnemyBullet> m_EnemyBullet = new ArrayList <EnemyBullet> ();
  
  void UpdateBullet()
  {    
    for (int i = 0; i < m_EnemyBullet.size(); i++)
    {
      EnemyBullet eb = m_EnemyBullet.get(i);
      eb.moveForward();
      eb.drawObj();
      eb.checkBulletDead();
    }     
  } 
  
  void CheckBulletDead()
  {
    for (int i = 0; i < m_EnemyBullet.size(); i++)
    {
      EnemyBullet eb = m_EnemyBullet.get(i);
      
      if(eb.isDead) m_EnemyBullet.remove(i);
      
    }    
  }
  
  void CleanBullets()
  {
    for (int i = 0; i < m_EnemyBullet.size(); i++)
    {
      m_EnemyBullet.remove(i);      
    }    
  }
} 

class Enemy1 extends Enemy
{
  
  Enemy1 (float x1, float y1, PImage Img, PImage bulletImg, int health1, float speed1)
  {
    x = x1;
    y = y1;    
    Enemy = Img;
    EnemyBullet = bulletImg;
    health = health1;
    speed = speed1;
  }
  
  void Update()
  {
    Move();
    DrawObj();
    CheckDead();
    UpdateBullet();
    CheckBulletDead();
    
    Fire();
  }  
  
  void Move()
  {
     x -= 2;   
     y += 3;
  }
  
  void DrawObj()
  {
    image(Enemy, x, y, x_added, y_added);
  }
  
  void CheckDead()
  {
    if (health <= 0) isDead = true; 
    else if (x < -50) isDead = true;
  }  
  
  void Fire()
  {
    int rnd = int (random (1, 1000));
    
    if (rnd > 990) m_EnemyBullet.add (new EnemyBullet (x, y, loadImage("bullet.png"), 50, 10, 10));
    
  } 
   
}