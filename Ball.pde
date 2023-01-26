//Bullet class//
//Initializing variables in class//
//Increasing the x and position of the bullet and dsiplaying//
//bullet collision with enemy//
class Ball {
  float x, y;
  float bulletXSpeed = 7;
  float bulletYSpeed = 7;
  boolean up = false;
  boolean down = false;
  boolean right = false;
  boolean left = false;


  Ball(float x, float y, float bulletXSpeed, float bulletYSpeed) {
    this.x = x;
    this.y = y;
    this.bulletXSpeed = bulletXSpeed;
    this.bulletYSpeed = bulletYSpeed;
  }
  
  void bulletMove(){
      this.x += bulletXSpeed;
      this.y += bulletYSpeed;
  }

  
  void displayShots() {
    ellipse(this.x, this.y, 5, 5);
  }
 
  void bulletCollision(){
    for (int i = 0; i < shots.size(); i++) {
      Ball ball = shots.get(i);
      for (int j = 0; j < enemies.size(); j++) {
      Enemy enemy = enemies.get(j);
        float distance = dist(ball.x, ball.y, enemy.x, enemy.y);
        if (distance < 20) {
          shots.remove(i);
          enemy.health -= player.bulletDamage;
          if (enemy.health <= 0){
            enemies.remove(j);
          }
        }
      }
    }
  }
}
