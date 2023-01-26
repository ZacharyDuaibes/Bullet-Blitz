//Player class//
//Initializing variables in class//
//Increasing/decreasing x/y coordinate depending on which keys are pressed//
//Collision with the window//
class Player{
  float x = 100;
  float y = 100;
  float r = 40;
  float SPEED = 5;
  float bulletDamage = 0.5;
  boolean w = false;
  boolean s = false;
  boolean a = false;
  boolean d = false;
  int lives = 1;


  Player(float x, float y, float r, float SPEED, float bulletDamage){
    this.x = x;
    this.y = y;
    this.r = r;
    this.SPEED = SPEED;
    this.bulletDamage = bulletDamage;
  }
  
  void display(){
    ellipse(this.x, this.y, this.r, this.r);
  }
  
  void move(){
    if (w){
      y -= SPEED;
    }
    if (s){
      y += SPEED;
    }
    if (d){
      x += SPEED;
    }
    if (a){
      x -= SPEED;
    }
  }
  
  void windowCollision(){
    if (x <= 30){
      x = 30;
    }
    if (x >= 970){
      x = 970;
    }
    if (y <= 30){
      y = 30;
    }
    if (y >= 720){
      y = 720;
    }
  }
    
}
