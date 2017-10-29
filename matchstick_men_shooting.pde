///This is the main class of the game, I think this can demonstrate how I understand the language and the logic of game design

import ddf.minim.*;

ArrayList <Terrain> m_Terrain = new ArrayList <Terrain> ();
ArrayList <Enemy1> m_Enemy1 = new ArrayList <Enemy1> ();
Player m_Player = new Player();

Minim minim;
AudioPlayer bg; 
AudioSnippet fire;

PImage title;
PImage instruction;
PImage lose;
PImage win;

int stage = 1;
int NumberOfTerrain = 1;
int enemyDead = 0;

boolean[] keys = new boolean [255];
boolean gameOver = false;
boolean gameWin = false;

void setup()
{  
  size (1000, 800);  
  
  minim = new Minim (this);
  bg = minim.loadFile("02.mp3");
  fire = minim.loadSnippet("fire.mp3");
  
  MakeTerrain();
 // m_Terrain.add (new Terrain(0 , 500));  
  title = loadImage("TITLE.png");
  instruction = loadImage("instruction.png");
  lose = loadImage("lose.jpg");
  win = loadImage("win.jpg");
  
  m_Player.SetupPlayerImage();
  
  m_Enemy1.add (new Enemy1 (500, 300, loadImage("enemy.png"), loadImage("bullet.png"), 100, 10));
  
}


void draw()
{
  if (stage == 1)
  {
    background(0);
    
    gameOver = false;
    gameWin = false;
    
    Clean();
   // bg.loop();
    image(title, 0, 0, width, height);    
  } 
  else if (stage == 2)
  {
    background(0);
    image(instruction, 0, 0, width, height);
  } 
  else if (stage == 3)
  {
    background(255);
        
    MakeEnemy();
    
    m_Player.Update();              
  
    UpdateEnemy();
    UpdateTerrain();
    UpdateUI();
    
    CheckStanding();
    CheckCollide();  
    
    fill(255);
    text("HP: " + m_Player.Health, 50, 700);
   
    text("Kill 20 Enemy will win the game", 300, 600);
    text("Enemy Slain: " + enemyDead, 250, 700);
    
    if (mousePressed && mouseButton == RIGHT)
    {      
      m_Player.UseShield();
      m_Player.UpdateShield();  
    }
    
    
    
    if (m_Player.Health <= 0) gameOver = true;
    
    if (enemyDead > 20) gameWin = true;    
        
    if (gameOver) 
    {
      Clean();
      stage = 4;
    }
    
    if (gameWin)
    {
      Clean();
      stage = 5;
    }
    
    if (keys['a'] || keys['A']) {m_Player.x -= 2;}
    if (keys['d'] || keys['D']) {m_Player.x += 1.5;}
    /*
    if (keyPressed && key == 'a' || key == 'A') m_Player.x -= 2;          
    if (keyPressed && key == 'd' || key == 'D') m_Player.x += 1.5;  */
    
  } 
  else if (stage == 4)
  {
    image (lose, 0, 0, width, height);    
  }
  else if (stage == 5)
  {
    image (win, 0, 0, width, height);
  }
}

void mousePressed()
{
  if (mouseButton == LEFT)
  {
    m_Player.Fire();         
    fire.rewind();
    fire.play();    
  }  
} 

void keyPressed()
{
  keys [keyCode] = true;  
}

void keyReleased()
{
  keys [keyCode] = false;  
}

void mouseClicked()
{
  if (stage == 1) stage = 2;
  else if (stage == 2) stage = 3;
  else if (stage == 4 || stage == 5) stage = 1;  
}

void UpdateUI()
{
  
}

void UpdateEnemy()
{
  for (int i = 0; i < m_Enemy1.size(); i++)
  {
    Enemy1 e1 = m_Enemy1.get(i);
    
    e1.Update();
    
    if (e1.isDead)
    {
      m_Enemy1.remove(i);      
    }     
  }  
}

void UpdateTerrain()
{
   for (int i = 0; i < m_Terrain.size(); i++)
  {
    Terrain te = m_Terrain.get(i);
    
    te.updateTerrain();       
                     
    if (te.CheckPlayerStanding(m_Player))
    {        
      m_Player.y = te.y - m_Player.y_added;        
    }                
    
    if (m_Player.x > width/3 && keyPressed && key == 'd' || key == 'D' || key == 'a' || key == 'A')
    {
      te.x -= 1;
    } 
     // println(te.checkStanding(p));      
  }   
   
}

void MakeTerrain()
{    
  for (NumberOfTerrain = 0; NumberOfTerrain < 100; NumberOfTerrain++)
  {
    m_Terrain.add (new Terrain (200*NumberOfTerrain, random (430, 470)));    
  }    
}

void MakeEnemy()
{
  int rnd = (int) random (0, 1000);
  
  if (rnd > 980)
  {
    m_Enemy1.add (new Enemy1 (random (width), 0, loadImage("enemy.png"), loadImage("bullet.png"), 100, 10)); 
    
  }  
  
}

void CheckCollide()
{
  // enemy
  
  for (int i = 0; i < m_Enemy1.size(); i++)
  {
    Enemy1 e1 = m_Enemy1.get(i);    
                              
    for (int j = 0; j < m_Player.m_PlayerBullet1.size(); j++)
    {
      PlayerBullet1 pb1 = m_Player.m_PlayerBullet1.get(j);  
      
      if (pb1.x > e1.x && pb1.y > e1.y 
      && pb1.x < e1.x + e1.x_added && pb1.y < e1.y + e1.y_added)
      {
        pb1.isDead = true;        
                   
        e1.health -= pb1.Damage;
        
        if (e1.health == 0)
        {
          enemyDead += 1;
          println(enemyDead);   
        } 
        
       } 
      
    }                
        
  }   
    
    // player                          
    
    for(int i = 0; i < m_Enemy1.size(); i++)
    {
      Enemy e = m_Enemy1.get(i);
      
      for(int j = 0; j < e.m_EnemyBullet.size(); j++)
      {
        EnemyBullet eb = e.m_EnemyBullet.get(j);
        
        if(eb.x > m_Player.x + m_Player.x_added || eb.y > m_Player.y + m_Player.y_added
        || eb.x + eb.x_added < m_Player.x || eb.y + eb.y_added < m_Player.y)
        {
          
        } else {
          eb.isDead = true;
          m_Player.Health -= eb.Damage;
        }
      }
    }      
    
    ///shield
    
    for(int i = 0; i < m_Enemy1.size(); i++)
    {
      Enemy e = m_Enemy1.get(i);
      
      for(int j = 0; j < e.m_EnemyBullet.size(); j++)
      {
        EnemyBullet eb = e.m_EnemyBullet.get(j);
        
        
        if(eb.x > m_Player.m_Shield.x && eb.y > m_Player.m_Shield.y 
        && eb.x < m_Player.m_Shield.x + m_Player.m_Shield.x_added && eb.y < m_Player.m_Shield.y + m_Player.m_Shield.y_added)
        {
          println("Defence!");
          eb.isDead = true;
         // m_Player.Health -= eb.Damage;
        }
        
        if(eb.x + eb.x_added > m_Player.m_Shield.x + m_Player.m_Shield.x_added && eb.y + eb.y_added > m_Player.m_Shield.y 
        && eb.x + eb.x_added < m_Player.m_Shield.x && eb.y + eb.y_added < m_Player.m_Shield.y + m_Player.m_Shield.y_added)
        {
          println("Defence!");
          eb.isDead = true;
         // m_Player.Health -= eb.Damage;
        }
      }
    } 
  
}

void CheckStanding()
{
  for (int i = 0; i < m_Terrain.size(); i++)
  {
    Terrain te = m_Terrain.get(i);
    
    te.updateTerrain();       
                     
    if (te.CheckPlayerStanding(m_Player))
    {        
      m_Player.y = te.y - m_Player.y_added;        
    }                
     // println(te.checkStanding(p));      
  }  
   
   for (int i = 0; i < m_Terrain.size(); i++)
  {
    Terrain te = m_Terrain.get(i);
    
    for (int j = 0; j < m_Enemy1.size(); j++)
    {
      Enemy1 e = m_Enemy1.get(j);
      
      if (te.CheckEnemy1Standing(e))
     {        
       e.y = te.y - e.y_added;        
     }        
     
    }                  
         
  } 
   
}

void Clean()
{
  m_Player.Health = 500;
  m_Player.x = 50;
  m_Player.y = 50;
  enemyDead = 0;
  
  for(int i = 0; i < m_Player.m_PlayerBullet1.size(); i++)
    m_Player.m_PlayerBullet1.remove(i);
      
  for(int i = 0; i < m_Enemy1.size(); i++)
  {
    Enemy1 e = m_Enemy1.get(i);
    
    e.CleanBullets();
    m_Enemy1.remove(i);
  }
  
  for(int i = 0; i < m_Terrain.size(); i++)
  {
    Terrain t = m_Terrain.get(i);        
    
  }
}
