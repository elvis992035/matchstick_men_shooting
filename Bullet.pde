class Bullet
{
  PImage bulletImg;
  
  float x, x_added = 5, y, y_added = 5;
  int Damage;
  float speedx, speedy;
  
  boolean isDead = false;
  
  Player player = new Player();
} 

class PlayerBullet1 extends Bullet
{
  PlayerBullet1 (float x1, float y1, PImage img, int damage1, int speedx1, int speedy1)
  {
    x = x1;
    y = y1;
    bulletImg = img;
    Damage = damage1;
    speedx = speedx1 * ((mouseX - x)/sqrt(sq(x - mouseX) + sq(y - mouseY)));
    speedy = speedy1 * ((mouseY - y)/sqrt(sq(x - mouseX) + sq(y - mouseY)));
  }  
  
  void drawObj()
  {
    image (bulletImg, x, y, x_added, y_added);    
  } 
  
  void moveForward()
  {
    x += speedx;
    y += speedy;    
  } 
  
  void checkBulletDead()
  {
    if (x > width + 50 || y > height + 50 || x < -50 || y < -50)
    {
      isDead = true;
    } 
    
  }       
}

class EnemyBullet extends Bullet
{
  EnemyBullet (float x1, float y1, PImage img, int damage1, int speedx1, int speedy1)
  {
    x = x1;
    y = y1;
    bulletImg = img;
    Damage = damage1;
    speedx = speedx1 * ((mouseX - x)/sqrt(sq(x - mouseX ) + sq(y - mouseY)));
    speedy = speedy1 * ((mouseY  - y)/sqrt(sq(x - mouseX ) + sq(y - mouseY)));
  }  
  
  void drawObj()
  {
    image (bulletImg, x, y, x_added, y_added);    
  } 
  
  void moveForward()
  {
    x += speedx;
    y += speedy;    
  } 
  
  void checkBulletDead()
  {
    if (x > width + 50 || y > height + 50 || x < -50 || y < -50)
    {
      isDead = true;
    } 
    
  }       
}